# frozen_string_literal: true

module Api
  # Client for SKP API
  class SkpClient
    require 'http'
    require 'oj'
    URL = 'https://skp.madiunkota.go.id/api'
    H = HTTP.accept(:json)
    attr_accessor :kode_opd, :bulan, :tahun, :nip_asn

    USERNAME = 'bappeda'
    PASSWORD = 'bapp7832KH'

    def initialize(kode_opd, tahun, bulan, nip_asn = '')
      # @kode_opd = '2.16.2.20.2.21.04.0000'
      # @tahun = 2022
      # @bulan = 2
      # tipe_asn = 'pns' | 'non_pns'
      @kode_opd = kode_opd
      @tahun = tahun
      @bulan = bulan
      @nip_asn = nip_asn
    end

    def data_sasaran_asn_opd
      request_skp(kode_opd, tahun, bulan, nip_asn)
    end

    def data_pegawai
      request_pegawai(kode_opd, tahun, bulan)
    end

    def update_pegawai
      request = data_pegawai
      update_data_pegawai(request)
    end

    def update_sasaran
      request = data_sasaran_asn_opd
      update_data_sasaran(request)
    end

    def update_struktur
      request = request_struktur(kode_opd, tahun, bulan)
      update_struktur_pegawai(request)
    end

    private

    def request_skp(kode_opd, tahun, bulan, nip_asn)
      H.post("#{URL}/sasaran-kinerja-pegawai/#{kode_opd}/#{tahun}/#{bulan}/#{nip_asn}",
             form: { username: USERNAME, password: PASSWORD })
    end
    # https://skp.madiunkota.go.id/api/sasaran-kinerja-pegawai/1.02.2.14.0.00.03.0000/2022/5/199301212015071003

    def request_pegawai(kode_opd, tahun, bulan)
      H.post("#{URL}/data-pegawai-all/#{kode_opd}/#{tahun}/#{bulan}",
             form: { username: USERNAME, password: PASSWORD })
    end

    def request_struktur(kode_opd, tahun, bulan)
      H.post("#{URL}/struktur_pegawai/#{kode_opd}/#{tahun}/#{bulan}",
             form: { username: USERNAME, password: PASSWORD })
    end

    def update_data_sasaran(response) # rubocop:disable Metrics/MethodLength
      data = Oj.load(response.body)
      data_opd = data['data']['data_opd']
      pegawais = data['data']['data_pegawai']
      # pegawais.reject! { |pe| pe['eselon'].match(/^(2|3)/) }
      data_sasaran = []
      data_indikator = []
      data_tahapan = []
      data_renaksi = []
      data_manual_ik = []
      pegawais.each do |pegawai|
        next unless pegawai['list_rencana_kinerja']

        pegawai['list_rencana_kinerja'].each do |rencana|
          id_rencana = rencana['id']
          sasaran_kinerja = rencana['rencana_kerja']
          nip_asn = pegawai['nip']
          tahun = pegawai['tahun']
          data_sasaran << { sasaran_kinerja: sasaran_kinerja, tahun: tahun,
                            indikator_kinerja: nil, target: nil, satuan: nil,
                            nip_asn: nip_asn, id_rencana: id_rencana,
                            created_at: Time.now, updated_at: Time.now }
          next unless rencana['list_indikator']

          rencana['list_indikator'].each do |indikator|
            indikator_kinerja = indikator['iki']
            target = indikator['target']
            satuan = indikator['satuan']
            aspek = indikator['aspek']
            id_indikator = indikator['id']
            data_indikator << { indikator_kinerja: indikator_kinerja,
                                target: target, satuan: satuan,
                                id_indikator: id_indikator,
                                aspek: aspek, sasaran_id: id_rencana,
                                created_at: Time.now, updated_at: Time.now }
            # manual ik
            data_manual_ik << { gambaran_umum: indikator['list_manual_ik'].first['definisi'],
                                id_indikator_sasaran: id_indikator,
                                created_at: Time.now, updated_at: Time.now }
          end
          next unless rencana['list_rencana_aksi']

          rencana['list_rencana_aksi'].each do |rencana_aksi|
            id_rencana = rencana_aksi['id_rencana_kerja']
            tahapan_kerja = rencana_aksi['tahapan_kerja']
            id_rencana_aksi = rencana_aksi['id']
            data_tahapan << { tahapan_kerja: tahapan_kerja,
                              id_rencana_aksi: id_rencana_aksi,
                              id_rencana: id_rencana,
                              created_at: Time.now, updated_at: Time.now }
            rencana_aksi['list_bulan'].each do |aksi|
              bulan = aksi['bulan']
              target = aksi['target']
              id_rencana_aksi = aksi['id_tahapan']
              id_aksi_bulan = aksi['id']
              data_renaksi << { bulan: bulan, target: target.to_i,
                                id_rencana_aksi: id_rencana_aksi,
                                id_aksi_bulan: id_aksi_bulan,
                                created_at: Time.now, updated_at: Time.now }
            end
          end
        end
      end
      # Updater OPD
      # kode_opd = data_opd['id']
      # kode_unik_opd = data_opd['unit_id']
      # id_opd_skp = data_opd['id_sipd']
      # insert_to_opd = { kode_opd: kode_opd, kode_unik_opd: kode_unik_opd, id_opd_skp: id_opd_skp }
      # opd = Opd.find_by(kode_opd: kode_opd)
      # opd.update(insert_to_opd)
      data_renaksi.reject! { |renaksi| renaksi[:target].zero? }
      Sasaran.upsert_all(data_sasaran, unique_by: :id_rencana)
      IndikatorSasaran.upsert_all(data_indikator, unique_by: :id_indikator) unless data_indikator.blank?
      Tahapan.upsert_all(data_tahapan, unique_by: :id_rencana_aksi) unless data_tahapan.blank?
      Aksi.upsert_all(data_renaksi, unique_by: :id_aksi_bulan) unless data_renaksi.blank?
      data_manual_ik.each do |m|
        sasaran_dari_indikator = IndikatorSasaran.find_by(id_indikator: m[:id_indikator_sasaran]).sasaran.id
        m.merge!(sasaran_id: sasaran_dari_indikator)
      end
      LatarBelakang.upsert_all(data_manual_ik, unique_by: :id_indikator_sasaran)
    end

    def update_data_pegawai(response)
      kode_opd = Opd.find_by(kode_unik_opd: @kode_opd).kode_opd || '0'
      data = Oj.load(response.body)
      pegawais = data['data']
      data_pegawais = []
      pegawais.each do |pegawai|
        email = "#{pegawai['nip']}@madiunkota.go.id"
        nip = pegawai['nip']
        nama = pegawai['nama']
        jabatan = pegawai['jabatan']
        eselon = pegawai['eselon']
        pangkat = pegawai['pangkat']
        nama_pangkat = pegawai['nama_pangkat']
        id_bidang = pegawai['id_bidang']
        nama_bidang = pegawai['nama_bidang']
        password = User.new(password: 123_456).encrypted_password
        data_pegawais << { kode_opd: kode_opd, nik: nip, nama: nama, jabatan: jabatan,
                           eselon: eselon, pangkat: pangkat, nama_pangkat: nama_pangkat,
                           id_bidang: id_bidang, nama_bidang: nama_bidang, email: email,
                           encrypted_password: password,
                           created_at: Time.now, updated_at: Time.now }
      end
      data_pegawais.each do |data_p|
        User.upsert(data_p, unique_by: :nik)
      end
    end

    def update_struktur_pegawai(response)
      kode_opd = Opd.find_by(kode_unik_opd: @kode_opd).kode_opd || '0'
      data = Oj.load(response.body)
      pegawais = data['data']['data_pegawai']
      data_pegawais = []
      pegawais.each do |pegawai|
        nip = pegawai['nip']
        atasan = pegawai['atasan_nip']
        data_pegawais << { kode_opd: kode_opd, nik: nip, atasan: atasan }
      end
      kepala = data_pegawais.select { |pegawai| pegawai[:atasan].blank? }.first[:nik]
      data_pegawais.each do |data_p|
        tipe = ''
        if data_p[:atasan].blank?
          tipe = 'Kepala'
        elsif data_p[:atasan].present? && data_p[:atasan] == kepala
          tipe = 'Atasan'
        else
          tipe = 'User'
        end
        data_p.store(:type, tipe)
        u = User.find_by(nik: data_p[:nik])
        u&.update(data_p)
      end
    end
  end
end
