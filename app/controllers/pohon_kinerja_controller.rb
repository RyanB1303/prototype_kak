class PohonKinerjaController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[admin_filter filter_rekap filter_rekap_opd]
  before_action :clone_params, only: %i[clone_pokin_opd clone_pokin_kota]

  def kota; end

  def opd
    @opd = current_user.opd
    # nip_kepala = @opd.users.eselon2.first&.nik
    @pohons = @opd.pohons
    @strategis = @opd.strategis.where(role: 'eselon_2')
  end

  def asn
    @opd = current_user.opd
    @pohons = @opd.pohons
    @user = current_user
    @eselon = @user.eselon_user
    @strategis = Strategi.where(nip_asn: @user.nik).select(&:strategi_atasan)
    @strategi_kepala = @opd.strategis.where(nip_asn: @user.nik, role: 'eselon_2')
  end

  def admin_filter
    @kode_opd = params[:kode_opd]
    @tahun = cookies[:tahun]
    @opd = Opd.find_by(kode_unik_opd: @kode_opd)
    @pohons = @opd.pohons
    @strategis = @opd.strategis.where(role: 'eselon_2')
    @nama_opd = @opd.nama_opd
    render partial: 'pohon_kinerja/kotak_usulan_asn', locals: { role: 'eselon_2', role_bawahan: 'eselon_3' }
  end

  def print
    @opd = current_user.opd
    # nip_kepala = @opd.users.eselon2.first&.nik
    @pohons = @opd.pohons
    @strategis = @opd.strategis.where(role: 'eselon_2')
  end

  def excel_opd
    @tahun = cookies[:tahun] || '2023'
    opd_params = cookies[:opd]
    @timestamp = Time.now.to_formatted_s(:number)
    @opd = if opd_params
             Opd.find_by(kode_unik_opd: opd_params)
           else
             current_user.opd
           end
    @nama_opd = @opd.nama_opd
    @isu_opd = @opd.pohon_kinerja_opd(@tahun)
    # @rekap_jumlah = @opd.data_total_pokin(@tahun)
    @filename = "Pohon Kinerja #{@nama_opd} #{@tahun} - #{@timestamp}.xlsx"
    if @opd.id == 145
      render xlsx: "pohon_setda_excel", filename: @filename
    else

      render xlsx: "pohon_opd_excel", filename: @filename
    end
  end

  def excel_kota
    @tahun = cookies[:tahun] || '2023'
    @timestamp = Time.now.to_formatted_s(:number)
    @filename = "Pohon Kinerja Kota #{@tahun} - #{@timestamp}.xlsx"
    @isu_kota = IsuStrategisKotum.where('tahun ILIKE ?', "%#{@tahun}%").to_h do |isu_kota|
      [isu_kota, isu_kota.strategi_kotums.to_h do |str_kota|
        [str_kota, str_kota.pohons]
      end]
    end
    render xlsx: "pohon_kota_excel", filename: @filename
  end

  def pdf_kota
    @tahun = cookies[:tahun] || '2023'
    @timestamp = Time.now.to_formatted_s(:number)
    @filename = "Pohon Kinerja Kota #{@tahun} - #{@timestamp}"
    @isu_strategis_kota = IsuStrategisKotum.where(tahun: @tahun)
    respond_to do |format|
      format.html { render layout: 'blank' }
    end
  end

  def pdf_opd
    @tahun = cookies[:tahun] || '2023'
    opd_params = cookies[:opd]
    @opd = if opd_params
             Opd.find_by(kode_unik_opd: opd_params)
           else
             current_user.opd
           end
    @isu_opd = @opd.pohon_kinerja_opd(@tahun)
    @nama_opd = @opd.nama_opd
    respond_to do |format|
      format.html { render layout: 'blank' }
    end
  end

  def rekap; end

  def filter_rekap
    @tahun = cookies[:tahun] || '2023'
    @isu_kota = IsuStrategisKotum.where('tahun ILIKE ?', "%#{@tahun}%").to_h do |isu_kota|
      [isu_kota, isu_kota.strategi_kotums.to_h do |str_kota|
        [str_kota, str_kota.pohons]
      end]
    end
    render partial: 'pohon_kinerja/filter_rekap'
  end

  def rekap_opd
    @kode_opd = cookies[:opd]
    @opd = Opd.find_by(kode_opd: @kode_opd)
  end

  def filter_rekap_opd
    @tahun = cookies[:tahun] || '2023'
    opd_params = cookies[:opd]
    @opd = if opd_params
             Opd.find_by(kode_unik_opd: opd_params)
           else
             current_user.opd
           end
    @nama_opd = @opd.nama_opd
    @isu_opd = @opd.pohon_kinerja_opd(@tahun)
    @rekap_jumlah = @opd.data_total_pokin(@tahun)
    if @opd.id == 145
      render partial: 'pohon_kinerja/filter_rekap_setda'
    else
      render partial: 'pohon_kinerja/filter_rekap_opd'
    end
  end

  def clone_list_opd
    @isu_strategis = params[:isu_strategis]
    @opd_id = params[:opd_id]
    @tahun_sekarang = params[:tahun_sekarang]
    jenis = params[:jenis]
    @url = if jenis == 'opd'
             clone_pokin_opd_pohon_kinerja_index_path
           else
             clone_pokin_kota_pohon_kinerja_index_path
           end
    render partial: 'pohon_kinerja/form_clone'
  end

  def clone_pokin_opd
    if isu_straegis_cloned?
      redirect_to rekap_opd_pohon_kinerja_index_path, warning: "sudah dicloning"
    else
      cloner_opd(@isu_strategis_id, @kelompok_anggaran_id, @opd_id, @tahun_asal)
      redirect_to rekap_opd_pohon_kinerja_index_path, success: "Cloned"
    end
  end

  def clone_pokin_kota
    if isu_straegis_cloned?
      redirect_to rekap_pohon_kinerja_index_path, warning: "sudah dicloning"
    else
      cloner_kota(@isu_strategis_id, @kelompok_anggaran_id, @tahun_asal)
      redirect_to rekap_pohon_kinerja_index_path, success: "Cloned"
    end
  end

  private

  def clone_params
    @opd_id = params[:opd_id]
    @isu_strategis_id = params[:isu_strategis_id]
    @kelompok_anggaran_id = params[:kelompok_anggaran]
    @tahun_asal = params[:tahun_asal]
  end

  def isu_straegis_cloned?
    isu_asli = IsuStrategisKotum.find(@isu_strategis_id).isu_strategis
    IsuStrategisKotum.where('kode ILIKE ?', "%#{isu_asli}%").where('keterangan ILIKE ?', '%clone%').any?
  end

  def cloner_opd(isu_strategis_id, kelompok_anggaran_id, opd_id, tahun_asal)
    tahun_anggaran = KelompokAnggaran.find(kelompok_anggaran_id).kode_kelompok
    isu_strategis = IsuStrategisKotum.find(isu_strategis_id)
    clone = IsuStrategisKotumCloner.call(isu_strategis,
                                         tahun: tahun_anggaran,
                                         tahun_asal: tahun_asal,
                                         opd_id: opd_id,
                                         traits: [:per_opd])
    clone.persist!
  end

  def cloner_kota(isu_strategis_id, kelompok_anggaran_id, tahun_asal)
    tahun_anggaran = KelompokAnggaran.find(kelompok_anggaran_id).kode_kelompok
    isu_strategis = IsuStrategisKotum.find(isu_strategis_id)
    clone = IsuStrategisKotumCloner.call(isu_strategis,
                                         tahun: tahun_anggaran,
                                         tahun_asal: tahun_asal,
                                         traits: [:all_opd])
    clone.persist!
  end
end
