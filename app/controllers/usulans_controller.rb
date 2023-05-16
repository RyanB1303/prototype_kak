class UsulansController < ApplicationController
  before_action :check_params, only: %i[update_sasaran_asn hapus_usulan_dari_sasaran]

  def update_sasaran_asn
    sasaran = params[:sasaran_id]
    usulan = params[:usulan_id].to_i
    usulan_type = params[:usulan_type]
    u = Usulan.create(usulanable_id: usulan, usulanable_type: usulan_type, sasaran_id: sasaran)
    usulan = usulan_type.constantize.find(usulan)
    sasaran_update = Sasaran.find(sasaran)
    if usulan_type == 'Mandatori'
      sasaran_update.dasar_hukums.create!(judul: usulan.peraturan_terkait, peraturan: usulan.uraian, tahun: usulan.tahun)
    else
      sasaran_update.permasalahans.create!(jenis: 'Umum', permasalahan: usulan.uraian)
    end
    respond_to do |format|
      if u.save && usulan.update(sasaran_id: sasaran, status: 'menunggu_persetujuan')
        flash.now[:success] = 'Usulan berhasil ditambahkan'
        format.js { render 'update_sasaran_asn' }
      else
        flash.now[:error] = 'Terjadi kesalahan'
        format.js { render 'update_sasaran_asn', status: :unprocessable_entity }
      end
    end
  end

  def hapus_usulan_dari_sasaran
    usulan = params[:usulan_id].to_i
    usulan_type = params[:usulan_type]
    u = Usulan.find_by(usulanable_id: usulan)
    usulan = usulan_type.constantize.find(usulan)
    respond_to do |format|
      if u.destroy
        usulan.update(sasaran_id: nil)
        flash.now[:success] = 'Usulan berhasil dihapus'
        format.js { render 'update_sasaran_asn' }
      else
        flash.now[:error] = 'Usulan gagal dihapus'
        format.js { render 'update_sasaaran_asn', status: :unprocessable_entity }
      end
    end
  end

  def laporan_usulan
    # render laporan usulan
    @jenis = params[:jenis]
    @jenis_asli = @jenis
    if @jenis == 'inisiatif'
      @jenis_asli = 'inisiatif walikota'
    end
  end

  def pdf_usulan
    # render laporan usulan
    @jenis = params[:jenis]
    @jenis_asli = @jenis
    @kode_opd = params[:opd]
    if @jenis == 'Inisiatif Walikota'
      @jenis = 'Inovasi'
      @jenis_asli = 'inisiatif walikota'
    end
    if @kode_opd == 'all_opd'
      @program_kegiatans = ProgramKegiatan.includes(%i[opd usulans])
                                          .where(usulans: { usulanable_type: @jenis })
                                          .select { |p| p.sasarans.exists? }
      @nama_opd = 'all_opd'
      @nama_file = @nama_opd
    else
      @program_kegiatans = ProgramKegiatan.includes(%i[opd usulans]).where(opds: { id_opd_skp: @kode_opd })
                                          .where(usulans: { usulanable_type: @jenis })
                                          .select { |p| p.sasarans.exists? }
      @nama_opd = Opd.find_by(id_opd_skp: @kode_opd).nama_opd
      @nama_file = @nama_opd
    end
    @tahun = params[:tahun] || Time.now.year
    @waktu = Time.now.strftime("%d_%m_%Y_%H_%M")
    @filename = "Laporan_USULAN_#{@jenis_asli}_#{@nama_file}_#{@waktu}.pdf"
  end

  def excel_usulan
    # render laporan usulan
    @jenis = params[:jenis]
    @jenis_asli = @jenis
    @kode_opd = params[:opd]
    if @jenis == 'Inisiatif Walikota'
      @jenis = 'Inovasi'
      @jenis_asli = 'inisiatif walikota'
    end
    if @kode_opd == 'all_opd'
      @program_kegiatans = ProgramKegiatan.includes(%i[opd usulans])
                                          .where(usulans: { usulanable_type: @jenis })
                                          .select { |p| p.sasarans.exists? }
      @nama_opd = 'all_opd'
      @nama_file = @nama_opd
    else
      @program_kegiatans = ProgramKegiatan.includes(%i[opd usulans]).where(opds: { id_opd_skp: @kode_opd })
                                          .where(usulans: { usulanable_type: @jenis })
                                          .select { |p| p.sasarans.exists? }
      @nama_opd = Opd.find_by(id_opd_skp: @kode_opd).nama_opd
      @nama_file = @nama_opd
    end
    @tahun = params[:tahun] || Time.now.year
    @waktu = Time.now.strftime("%d_%m_%Y_%H_%M")
    @filename = "Laporan_USULAN_#{@jenis_asli}_#{@nama_file}_#{@waktu}.xlsx"
    render xlsx: "excel_usulan", filename: @filename, disposition: "inline"
  end


  private

  def check_params
    if params[:usulan_type].empty? && params[:usulan_id].empty?
      render 'shared/_notifier', locals: { message: 'Usulan belum diambil' }, status: :unprocessable_entity
    end
  end
end
