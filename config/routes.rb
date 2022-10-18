# frozen_string_literal: true

# == Route Map
#

# require 'resque/server'
require "sidekiq/web"
require "sidekiq-status/web"
require "sidekiq_unique_jobs/web"

Rails.application.routes.draw do
  # get "/gender", to: "genders#gender"
  # get "/gap_gender", to: "genders#gap_gender"
  # get "/laporan_gender", to: "genders#laporan_gender"
  # get "/pdf_gender/:id/:tahun", to: "genders#pdf_gender"
  resources :genders do
    collection do
      get :gender
      get :gap
      get :gbs
      get :laporan_gender
      get 'pdf_gender/:id/:tahun', to: 'genders#pdf_gender'
      get 'pdf_gap_gender/:id/:tahun', to: 'genders#pdf_gap_gender'
    end
  end
  resources :tujuans
  # get 'isu_dan_permasalahans/index'
  resources :renstra do
    collection do
      get :admin_renstra
    end
    post :update_programs, on: :member
  end

  resources :isu_dan_permasalahans, param: :kode_program do
    member do
      get :add_new
      post :add_isu_strategis
    end
  end

  resources :kemungkinans
  resources :skalas
  resources :dampaks
  resources :anggaran_hspks
  resources :anggaran_sbus
  resources :anggaran_sshes
  resources :anggaran_bluds
  resources :anggaran_hspk_umums
  resources :subkegiatan_tematiks, path: "tematiks" do
    member do
      get :cetak_pdf
    end
  end

  resources :rekenings
  resources :musrenbangs do
    member do
      post :toggle_is_active
      post :diambil_asn
      post :setujui_usulan_di_sasaran
    end
  end

  resources :pokpirs do
    member do
      post :toggle_is_active
      post :diambil_asn
      post :setujui_usulan_di_sasaran
    end
  end

  resources :inovasis do
    member do
      post :toggle_is_active
      post :diambil_asn
      post :setujui_usulan_di_sasaran
    end
  end

  resources :mandatoris do
    member do
      post :toggle_is_active
      post :diambil_asn
      post :setujui_usulan_di_sasaran
    end
  end

  resources :asn_musrenbangs, path: "asn_usulan"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root to: "home#dashboard"
  resources :users do
    resources :sasarans, path: "sasaran_kerja"
    collection do
      get :struktur
      get :khusus
      get :dropdown_user
    end

    member do
      get :edit_detail
      patch :update_detail
    end
  end

  resources :atasans
  resources :kepalas
  resources :sasarans do
    collection do
      get :list_sasaran
    end
    member do
      get :data_detail
      get :rencana_aksi
    end
    resources :rincians do
      get "subkegiatan", on: :new
    end

    resources :tahapans do
      resources :aksis, path: "rencana_aksi"
      resources :anggarans
    end

    resources :permasalahans
    resources :dasar_hukums
    resources :latar_belakangs, path: "gambaran_umum"
    member do
      post :ajukan_verifikasi
      post :setujui
      post :tolak
      post :revisi
      get :detail
      get :clone_form
      post :clone
      post :pilih_asn
    end
  end

  resources :kelompok_anggarans do
    collection do
      get :cloning
    end
  end

  # resources :rincians do
  #   resources :tahapans do
  #     resources :aksis, :path => "rencana_aksi"
  #     resources :anggarans
  #   end

  # end

  resources :anggarans do
    resources :perhitungans do
      collection do
        get :new_gaji
      end

      member do
        get :edit_gaji
      end
    end
  end

  resources :perhitungans, shallow: true do
    resources :koefisiens
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :kaks, path: "acuan_kerja"
  resources :lembagas
  resources :opds do
    collection do
      get :tujuan
      get :sasaran
    end
  end
  resources :program_kegiatans do
    member do
      get :subgiat_edit
      patch :subgiat_update
      get :giat_edit
      patch :giat_update
      get :program_edit
      patch :program_update
      get :detail_sasarans
      get :rencana_aksi
    end
    collection do
      get :list_program_with_sasarans_rincian
    end
  end

  resources :pajaks
  resources :kesenjangans
  resources :strategi_keluarans, path: "strategi"
  resources :comments, except: %i[index show]
  resources :roles
  resources :sumber_danas, except: %i[show]
  resources :kamus_usulans
  resources :laporans, only: %i[index] do
    collection do
      get :atasan
    end
  end

  resources :rekaps, param: :kode_unik_opd do
    get "jumlah", on: :collection
  end

  resources :sasaran_program_opds do
    collection do
      get :spip
      get :excel_spip
      get :daftar_resiko
    end

    get :add_dampak_resiko
  end

  namespace :filter do
    post :daftar_resiko
    post :isu_strategis_permasalahan
    post :laporan_renstra
    get :tahun_sasaran
    post :renstra_master
    post :tujuan_opd
    post :sasaran_opd
    post :crosscutting_kota
  end

  scope module: 'api' do
    namespace :sipd_client do
      get :sync_renstra
    end
  end

  namespace :api do
    namespace :programs do
      post :indikators
      post :permasalahans
      post :opd_program
      post :opd_kegiatan
      post :opd_subkegiatan
      post :opd_test_indikator_program
      post :opd_test_renstra_program
      post :opd_test_indikator_kegiatan
      post :opd_test_renstra_kegiatan
      post :opd_test_indikator_subkegiatan
      post :opd_test_renstra_subkegiatan
      post :kota_test_indikator_program
      post :kota_test_indikator_kegiatan
      post :kota_test_indikator_subkegiatan
    end
  end

  resources :sasaran_kota
  resources :tujuan_kota
  get :crosscutting_kota, to: "sasaran_kota#crosscutting_kota"

  mount Sidekiq::Web, at: "/sidekiq"

  # resque
  # authenticate :user, ->(u) { u.id == 1 } do
  #   get '/sidekiq'
  # end

  # sasaran
  get "/verifikasi_sasarans", to: "sasarans#verifikasi_sasaran"
  get "/laporan_sasarans", to: "sasarans#laporan_sasaran"
  post "/hapus_program_from_sasaran", to: "sasarans#hapus_program_from_sasaran"
  post "/hapus_tematik_from_sasaran", to: "sasarans#hapus_tematik_from_sasaran"
  post "/add_sasaran_tematik", to: "sasarans#add_sasaran_tematik"
  post "/ajukan_semua_sasaran", to: "sasarans#ajukan_semua_sasaran"
  post "/setujui_semua_sasaran", to: "sasarans#setujui_semua_sasaran"
  post "/revisi_semua_sasaran", to: "sasarans#revisi_semua_sasaran"
  post "/tolak_semua_sasaran", to: "sasarans#tolak_semua_sasaran"
  # user control
  post "/aktifkan_user/:id", to: "users#aktifkan_user"
  post "/nonaktifkan_user/:id", to: "users#nonaktifkan_user"
  post "/hapus_asn/:id", to: "users#hapus_asn"
  post "/nonaktifkan_semua_user/:opd", to: "users#nonaktifkan_semua_user"
  get "/user_search", to: "users#user_search"
  # program program_kegiatan
  get "/program_kegiatans_to_kak/:id", to: "program_kegiatans#show_to_kak"
  get "/program_kegiatans_to_kak_detail/:id", to: "program_kegiatans#kak_detail"
  get "/program_kegiatans_to_kak_renaksi/:id", to: "program_kegiatans#kak_renaksi"
  get "/program_kegiatans_to_kak_waktu/:id", to: "program_kegiatans#kak_waktu"
  get "/acuan_kerja_new/:id/:tahun", to: "program_kegiatans#new_kak_format"

  # musrenbang
  get "/asn_musrenbangs/:nip", to: "musrenbangs#asn_musrenbang"
  post "/update_opd", to: "musrenbangs#update_opd"
  post "/update_opd_pokpir", to: "pokpirs#update_opd"
  # search usulans
  get "/musrenbang_search", to: "musrenbangs#musrenbang_search"
  get "/mandatori_search", to: "mandatoris#mandatori_search"
  get "/pokpir_search", to: "pokpirs#pokpir_search"
  get "/inovasi_search", to: "inovasis#inovasi_search"
  # delete later
  patch "/aktifkan_usulan/:id", to: "musrenbangs#aktifkan_usulan"
  patch "/non_aktifkan_usulan/:id", to: "musrenbangs#non_aktifkan_usulan"
  # usulans
  post "/update_sasaran_asn", to: "usulans#update_sasaran_asn"
  post "/hapus_usulan_dari_sasaran", to: "usulans#hapus_usulan_dari_sasaran"
  # pokpir delete later
  patch "/aktifkan_pokpir/:id", to: "pokpirs#aktifkan_pokpir"
  patch "/non_aktifkan_pokpir/:id", to: "pokpirs#non_aktifkan_pokpir"
  # laporan kak
  get "/laporan_kak", to: "kaks#laporan_kak"
  get "/pdf_kak/:id/:tahun", to: "program_kegiatans#pdf_kak"
  get "/cetak_daftar_kak/:opd/:tahun", to: "program_kegiatans#cetak_daftar_kak"
  # daftar resiko
  get '/cetak_daftar_resiko/:opd/:tahun', to: 'sasaran_program_opds#cetak_daftar_resiko'
  # laporan rka
  get "/rincian_belanja", to: "program_kegiatans#laporan_rka"
  get "/pdf_rka/:id/:tahun", to: "program_kegiatans#pdf_rka"
  #  Sasaran
  get "/daftar_subkegiatan", to: "sasarans#daftar_subkegiatan"
  get "/pdf_daftar_subkegiatan", to: "sasarans#pdf_daftar_subkegiatan"
  post "/renaksi_update", to: "sasarans#renaksi_update"

  # Tahapan
  # Anggaran
  get "/anggaran_ssh_search", to: "anggaran_sshes#anggaran_ssh_search"
  get "/anggaran_spesifikasi_search", to: "anggaran_sshes#anggaran_spesifikasi_search"
  get "/anggaran_hspk_search", to: "anggaran_hspks#anggaran_hspk_search"
  post "/perhitungan_update", to: "anggarans#perhitungan_update"

  # Reknening
  get "/rekening_search", to: "rekenings#rekening_search"

  # admin thing
  get "/adminsasarans", to: "sasarans#sasaran_admin"
  get "/adminusers", to: "users#user_admin"
  get "/admin_program", to: "program_kegiatans#admin_program"
  get "/admin_kegiatan", to: "program_kegiatans#admin_kegiatan"
  get "/admin_sub_kegiatan", to: "program_kegiatans#admin_sub_kegiatan"
  get "/laporan_renja", to: "program_kegiatans#laporan_renja" # TODO: implement this
  get "/rasionalisasi", to: "rasionalisasi#rasionalisasi"
  get "/rasional_sasaran/:sasaran", to: "rasionalisasi#rasional_sasaran"
  get "/rasional_sasaran_anggaran/:sasaran", to: "rasionalisasi#rasional_sasaran_anggaran"

  get "/laporan_renja", to: "program_kegiatans#laporan_renja"
  get "/laporan_usulan/:jenis", to: "usulans#laporan_usulan"
  get "/pdf_usulan/:jenis/:opd/:tahun", to: "usulans#pdf_usulan"
  get "/excel_usulan/:jenis/:opd/:tahun", to: "usulans#excel_usulan"
  get "/laporan_tematik", to: "subkegiatan_tematiks#laporan_tematik"
  get "/laporan_tematik_apbd", to: "subkegiatan_tematiks#laporan_tematik_apbd"
  #
  # user_specific_thing
  get "/usulan_musrenbang", to: "musrenbangs#usulan_musrenbang"
  get "/usulan_pokpir", to: "pokpirs#usulan_pokpir"
  get "/usulan_mandatori", to: "mandatoris#usulan_mandatori"
  get "/usulan_inisiatif", to: "inovasis#usulan_inisiatif"
  # third party Api
  get "/sync_sasaran", to: "api/skp_client#sync_sasaran"
  get "/sync_pegawai", to: "api/skp_client#sync_pegawai"
  get "/sync_struktur_pegawai", to: "api/skp_client#sync_struktur_pegawai"
  get "/sync_opd", to: "api/skp_client#sync_opd"
  get "/sync_tujuan_opd", to: "api/skp_client#sync_tujuan_opd"
  get "/sync_kota", to: "api/skp_client#sync_kota"
  get "/sync_tujuan_kota", to: "api/skp_client#sync_tujuan_kota"
  get "/sync_subkegiatan", to: "api/sipd_client#sync_subkegiatan"
  get "/sync_subkegiatan_opd", to: "api/sipd_client#sync_subkegiatan_opd"
  get "/update_detail_kegiatan_lama", to: "api/sipd_client#update_detail_kegiatan_lama"
  get "/update_detail_kegiatan", to: "api/sipd_client#update_detail_kegiatan"
  get "/update_detail_subkegiatan", to: "api/sipd_client#update_detail_subkegiatan"
  get "/sync_musrenbang", to: "api/sipd_client#sync_musrenbang"
  get "/sync_pokpir", to: "api/sipd_client#sync_pokpir"
  get "/sync_kamus_usulan", to: "api/sipd_client#sync_kamus_usulan"
  get "/sync_data_opd", to: "api/sipd_client#sync_data_opd"
  post "/update_detail_program", to: "api/sipd_client#update_detail_program"
  post "/sync_indikator_program", to: "api/sipd_client#sync_indikator_program"
  post "/sync_indikator_kegiatan", to: "api/sipd_client#sync_indikator_kegiatan"
  post "/sync_master_program/:tahun", to: "master/program#sync_master_program"
  post "/sync_master_kegiatan/:tahun", to: "master/kegiatan#sync_master_kegiatan"
  post "/sync_master_subkegiatan/:tahun/:id_giat", to: "master/subkegiatan#sync_master_subkegiatan"
  post "/sync_master_subkegiatan_all", to: "master/subkegiatan#sync_master_subkegiatan_all"
  post "/sync_master_output_kegiatans/:tahun", to: "master/output_kegiatans#sync_master_output_kegiatans"
  post "/sync_master_urusan", to: "master/urusans#sync_master_urusan"
  post "/sync_master_bidang_urusan", to: "master/bidang_urusans#sync_master_bidang_urusan"
  # internal filter
  post "/filter_sasaran", to: "filter#filter_sasaran"
  post "/filter_user", to: "filter#filter_user"
  post "/filter_program", to: "filter#filter_program"
  # post "/indikator_program_opd_by_kode_program", to: "api/program_kak#indikator_program_opd_by_kode_program"
  post "/filter_kegiatan", to: "filter#filter_kegiatan"
  post "/filter_subkegiatan", to: "filter#filter_subkegiatan"
  post "/filter_kak", to: "filter#filter_kak"
  post "/filter_kak_dashboard", to: "filter#filter_kak_dashboard"
  post "/filter_rab", to: "filter#filter_rab"
  post "/filter_rasionalisasi", to: "filter#filter_rasionalisasi"
  post "/filter_gender", to: "filter#filter_gender"
  post "/filter_opd", to: "filter#filter_opd"
  post "/filter_usulan", to: "filter#filter_usulan"
  post "/filter_user_sasarans", to: "filter#filter_user_sasarans"
  post "/filter_tematiks", to: "filter#filter_tematiks"
  post "/filter_tematiks_apbd", to: "filter#filter_tematiks_apbd"
  post "/filter_struktur", to: "filter#filter_struktur"
  post "/filter_rekap_jumlah", to: "filter#filter_rekap_jumlah"

  get "/all_opd", to: "opds#all_opd"
  get "/destroy_all", to: "program_kegiatans#destroy_all"
  get "/master_programs", to: "master/program#index"
  get "/master_kegiatans", to: "master/kegiatan#index"
  get "/master_subkegiatans", to: "master/subkegiatan#index"
  get "/master_output", to: "master/output_kegiatans#index"
  get "/master_urusan", to: "master/urusans#index"
  get "/master_bidang_urusan", to: "master/bidang_urusans#index"
  # get "/program_kegiatans", to: "program_kegiatans#index"
  # get "/program_kegiatans/new", to: "program_kegiatans#new"
  # get "/program_kegiatan/:id", to: "program_kegiatans#show"
  # post "/program_kegiatans", to: "program_kegiatans#create"
end
