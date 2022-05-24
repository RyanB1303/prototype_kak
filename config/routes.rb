# frozen_string_literal: true

require 'resque/server'
Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  resources :anggaran_hspks
  resources :anggaran_sbus
  resources :anggaran_sshes
  resources :anggaran_bluds
  resources :subkegiatan_tematiks, path: 'tematiks'
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
  resources :asn_musrenbangs, path: 'asn_usulan'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'home#dashboard'
  resources :users do
    resources :sasarans, path: 'sasaran_kerja'
  end
  resources :sasarans do
    resources :rincians do
      get 'subkegiatan', on: :new
    end
    resources :tahapans do
      resources :aksis, path: 'rencana_aksi'
      resources :anggarans
    end
    resources :permasalahans
    resources :dasar_hukums
    resources :latar_belakangs, path: 'gambaran_umum'
    member do
      post :ajukan_verifikasi
      post :setujui
      post :tolak
      post :revisi
    end
  end

  # resources :rincians do
  #   resources :tahapans do
  #     resources :aksis, :path => "rencana_aksi"
  #     resources :anggarans
  #   end
  # end

  resources :anggarans do
    resources :perhitungans
  end

  resources :perhitungans, shallow: true do
    resources :koefisiens
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :kaks, path: 'acuan_kerja'
  resources :lembagas
  resources :opds
  resources :program_kegiatans
  resources :pajaks
  resources :kesenjangans
  resources :strategi_keluarans, path: 'strategi'
  resources :comments, except: %i[index show]
  resources :roles
  resources :sumber_danas, except: %i[show]
  resources :kamus_usulans

  # resque
  authenticate :user, ->(u) { u.id == 1 } do
    mount Resque::Server, at: '/jobs'
  end
  # sasaran
  get '/verifikasi_sasarans', to: 'sasarans#verifikasi_sasaran'
  get '/laporan_sasarans', to: 'sasarans#laporan_sasaran'
  post '/hapus_program_from_sasaran', to: 'sasarans#hapus_program_from_sasaran'
  post '/hapus_tematik_from_sasaran', to: 'sasarans#hapus_tematik_from_sasaran'
  post '/add_sasaran_tematik', to: 'sasarans#add_sasaran_tematik'
  post '/ajukan_semua_sasaran', to: 'sasarans#ajukan_semua_sasaran'
  post '/setujui_semua_sasaran', to: 'sasarans#setujui_semua_sasaran'
  post '/revisi_semua_sasaran', to: 'sasarans#revisi_semua_sasaran'
  post '/tolak_semua_sasaran', to: 'sasarans#tolak_semua_sasaran'
  # user control
  post '/aktifkan_user/:id', to: 'users#aktifkan_user'
  post '/nonaktifkan_user/:id', to: 'users#nonaktifkan_user'
  # program program_kegiatan
  get '/program_kegiatans_to_kak/:id', to: 'program_kegiatans#show_to_kak'
  get '/program_kegiatans_to_kak_detail/:id', to: 'program_kegiatans#kak_detail'
  get '/program_kegiatans_to_kak_renaksi/:id', to: 'program_kegiatans#kak_renaksi'
  get '/program_kegiatans_to_kak_waktu/:id', to: 'program_kegiatans#kak_waktu'
  get '/acuan_kerja_new/:id', to: 'program_kegiatans#new_kak_format'

  # musrenbang
  get '/asn_musrenbangs/:nip', to: 'musrenbangs#asn_musrenbang'
  post '/update_opd', to: 'musrenbangs#update_opd'
  post '/update_opd_pokpir', to: 'pokpirs#update_opd'
  # search usulans
  get '/musrenbang_search', to: 'musrenbangs#musrenbang_search'
  get '/mandatori_search', to: 'mandatoris#mandatori_search'
  get '/pokpir_search', to: 'pokpirs#pokpir_search'
  get '/inovasi_search', to: 'inovasis#inovasi_search'
  # delete later
  patch '/aktifkan_usulan/:id', to: 'musrenbangs#aktifkan_usulan'
  patch '/non_aktifkan_usulan/:id', to: 'musrenbangs#non_aktifkan_usulan'
  # usulans
  post '/update_sasaran_asn', to: 'usulans#update_sasaran_asn'
  post '/hapus_usulan_dari_sasaran', to: 'usulans#hapus_usulan_dari_sasaran'
  # pokpir delete later
  patch '/aktifkan_pokpir/:id', to: 'pokpirs#aktifkan_pokpir'
  patch '/non_aktifkan_pokpir/:id', to: 'pokpirs#non_aktifkan_pokpir'
  # laporan kak
  get '/laporan_kak', to: 'kaks#laporan_kak'
  get '/pdf_kak/:id/:tahun', to: 'program_kegiatans#pdf_kak'
  # laporan rka
  get '/laporan_rka', to: 'program_kegiatans#laporan_rka'
  get '/pdf_rka/:id/:tahun', to: 'program_kegiatans#pdf_rka'
  #  Sasaran
  get '/daftar_subkegiatan', to: 'sasarans#daftar_subkegiatan'
  get '/pdf_daftar_subkegiatan', to: 'sasarans#pdf_daftar_subkegiatan'
  post '/renaksi_update', to: 'sasarans#renaksi_update'

  # Tahapan
  # Anggaran
  get '/anggaran_ssh_search', to: 'anggaran_sshes#anggaran_ssh_search'
  get '/anggaran_spesifikasi_search', to: 'anggaran_sshes#anggaran_spesifikasi_search'

  # Reknening
  get '/rekening_search', to: 'rekenings#rekening_search'

  # admin thing
  get '/adminsasarans', to: 'sasarans#sasaran_admin'
  get '/adminusers', to: 'users#user_admin'
  get '/admin_program', to: 'program_kegiatans#admin_program'
  get '/admin_kegiatan', to: 'program_kegiatans#admin_kegiatan'
  get '/admin_sub_kegiatan', to: 'program_kegiatans#admin_program_kegiatan'
  get '/rasionalisasi', to: 'rasionalisasi#rasionalisasi'
  get '/rasional_sasaran/:sasaran', to: 'rasionalisasi#rasional_sasaran'
  get '/rasional_sasaran_anggaran/:sasaran', to: 'rasionalisasi#rasional_sasaran_anggaran'
  get '/laporan_renja', to: 'program_kegiatans#laporan_renja'
  #
  # user_specific_thing
  get '/usulan_musrenbang', to: 'musrenbangs#usulan_musrenbang'
  get '/usulan_pokpir', to: 'pokpirs#usulan_pokpir'
  get '/usulan_mandatori', to: 'mandatoris#usulan_mandatori'
  get '/usulan_inisiatif', to: 'inovasis#usulan_inisiatif'
  # third party Api
  get '/sync_sasaran', to: 'api/skp_client#sync_sasaran'
  get '/sync_pegawai', to: 'api/skp_client#sync_pegawai'
  get '/sync_subkegiatan', to: 'api/sipd_client#sync_subkegiatan'
  get '/sync_subkegiatan_opd', to: 'api/sipd_client#sync_subkegiatan_opd'
  get '/update_detail_program', to: 'api/sipd_client#update_detail_program'
  get '/update_detail_kegiatan_lama', to: 'api/sipd_client#update_detail_kegiatan_lama'
  get '/update_detail_kegiatan', to: 'api/sipd_client#update_detail_kegiatan'
  get '/update_detail_subkegiatan', to: 'api/sipd_client#update_detail_subkegiatan'
  get '/sync_musrenbang', to: 'api/sipd_client#sync_musrenbang'
  get '/sync_pokpir', to: 'api/sipd_client#sync_pokpir'
  get '/sync_kamus_usulan', to: 'api/sipd_client#sync_kamus_usulan'
  get '/sync_data_opd', to: 'api/sipd_client#sync_data_opd'

  post '/filter_sasaran', to: 'filter#filter_sasaran'
  post '/filter_user', to: 'filter#filter_user'
  post '/filter_program_saja', to: 'filter#filter_program_saja'
  post '/filter_kegiatan', to: 'filter#filter_kegiatan'
  post '/filter_program', to: 'filter#filter_program'
  post '/filter_kak', to: 'filter#filter_kak'
  post '/filter_rab', to: 'filter#filter_rab'
  post '/filter_rasionalisasi', to: 'filter#filter_rasionalisasi'
  post '/filter_opd', to: 'filter#filter_opd'
  # get "/program_kegiatans", to: "program_kegiatans#index"
  # get "/program_kegiatans/new", to: "program_kegiatans#new"
  # get "/program_kegiatan/:id", to: "program_kegiatans#show"
  # post "/program_kegiatans", to: "program_kegiatans#create"
end
