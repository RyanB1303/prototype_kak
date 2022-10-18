class ProgramKegiatansController < ApplicationController
  before_action :set_program_kegiatan,
                only: %i[show edit update destroy
                         show_to_kak kak_detail kak_renaksi kak_waktu
                         subgiat_edit giat_edit program_edit
                         pdf_rka]
  before_action :set_dropdown, only: %i[new edit]

  layout false, only: %i[show_to_kak kak_detail kak_renaksi kak_waktu]

  def index
    # TODO: refactor untuk json query
    param = params[:q] || ""
    # FIXME: REFACTOR TOO MUCH LOGIC
    @programKegiatans = ProgramKegiatan.where("kode_opd ILIKE ?", "%#{current_user.kode_opd}%")
                                       .where("nama_subkegiatan ILIKE ?", "%#{param}%")
    if current_user.pegawai_kelurahan?
      @programKegiatans = @programKegiatans.select do |program|
        program.nama_opd_pemilik.upcase.split(/KELURAHAN/, 2).last.strip == current_user.petunjuk_kelurahan
      end
    elsif current_user.pegawai_bagian?
      @programKegiatans = @programKegiatans.select do |program|
        program.nama_opd_pemilik.upcase.split(/BAGIAN/, 2).last.strip == current_user.petunjuk_bagian
      end
    end
  end

  def list_program_with_sasarans_rincian
    param = params[:q] || ""
    @program_kegiatans = ProgramKegiatan.with_sasarans_rincian.where("kode_opd ILIKE ?", "%#{current_user.kode_opd}%")
                                        .where("nama_subkegiatan ILIKE ?", "%#{param}%")
    respond_to do |format|
      format.json
    end
  end

  def detail_sasarans
    @program_kegiatan = ProgramKegiatan.find(params[:id])
    render partial: 'detail_sasarans', locals: { program_kegiatan: @program_kegiatan }
  end

  def rencana_aksi
    @program_kegiatan = ProgramKegiatan.find(params[:id])
    render partial: 'rencana_aksi_program_kegiatan', locals: { program_kegiatan: @program_kegiatan }
  end

  def admin_sub_kegiatan
    @filter_url = "filter_subkegiatan"
    render :admin_program_kegiatan
  end

  def admin_program
    @filter_url = "filter_program"
    render :admin_program_kegiatan
  end

  def admin_kegiatan
    @filter_url = "filter_kegiatan"
    render :admin_program_kegiatan
  end

  def new
    @programKegiatan = ProgramKegiatan.new
  end

  def show; end

  def show_to_kak; end

  def kak_detail; end

  def kak_renaksi; end

  def kak_waktu; end

  def new_kak_format
    @program_kegiatan = ProgramKegiatan.find(params[:id])
    @tahun = params[:tahun] || Time.now.year
    render "new_kak_format"
  end

  def pdf_kak
    # respond_to do |format|
    #   format.pdf do
    #     @nama_file = ProgramKegiatan.find(params[:id]).nama_subkegiatan
    #     @tahun = params[:tahun] || Time.now.year
    #     @waktu = Time.now.strftime("%d_%m_%Y_%H_%M")
    #     @filename = "Laporan_KAK_#{@nama_file}_#{@waktu}.pdf"
    #     @program_kegiatan = ProgramKegiatan.find(params[:id])
    #     pdf = KakDocument.new(program_kegiatan: @program_kegiatan, tahun: @tahun)
    #     send_data pdf.render,
    #     filename: @filename,
    #     type: 'application/pdf',
    #     disposition: 'inline'
    #   end
    # end
    @nama_file = ProgramKegiatan.find(params[:id]).nama_subkegiatan
    @tahun = params[:tahun] || Time.now.year
    @tahun = @tahun.match(/murni/) ? @tahun[/[^_]\d*/, 0] : @tahun
    @waktu = Time.now.strftime("%d_%m_%Y_%H_%M")
    @filename = "Laporan_KAK_#{@nama_file}_#{@waktu}.pdf"
    @program_kegiatan = ProgramKegiatan.find(params[:id])
  end

  def laporan_rka
    @program_kegiatans = ProgramKegiatan.joins(:sasarans)
                                        .where(sasarans: { nip_asn: current_user.nik })
                                        .where.not(sasarans: { id: nil, anggaran: nil }).group(:id)
  end

  def pdf_rka
    @nama_file = ProgramKegiatan.find(params[:id]).nama_subkegiatan
    @tahun = params[:tahun] || Time.now.year
    @tahun = @tahun.match(/murni/) ? @tahun[/[^_]\d*/, 0] : @tahun
    @waktu = Time.now.strftime("%d_%m_%Y_%H_%M")
    @filename = "Laporan_RAB_#{@nama_file}_#{@waktu}.pdf"
  end

  def cetak_daftar_kak
    @tahun = params[:tahun]
    @opd = Opd.find(params[:opd])
    kode_opd = @opd.kode_unik_opd
    @kak = KakService.new(kode_unik_opd: kode_opd, tahun: @tahun)
    @program_kegiatans = @kak.laporan_rencana_kinerja

    @filename = "LAPORAN_DAFTAR_KAK_#{@opd.nama_opd}_TAHUN_#{@tahun}.pdf"
    respond_to do |format|
      format.html { render 'cetak_daftar_kak', layout: false }
      format.pdf do
        render pdf: @filename,
               disposition: 'attachment',
               footer: {
                 right: 'Hal. [page] / [topage]',
                 left: "#{@opd.nama_opd} tahun #{@kak.tahun}",
                 font_size: 7
               },
               template: 'program_kegiatans/cetak_daftar_kak.html.erb',
               layout: 'pdf',
               show_as_html: params.key?('debug'),
               orientation: 'Landscape',
               page_size: nil,
               page_height: '300mm',
               page_width: '215mm',
               enable_local_file_access: true
      end
    end
  end

  def edit; end

  def subgiat_edit
    @row_num = params[:row_num]
  end

  def giat_edit
    @row_num = params[:row_num]
  end

  def program_edit
    @row_num = params[:row_num]
  end

  def subgiat_update
    respond_to do |format|
      @row_num = params[:program_kegiatan][:row_num]
      id_sub = params[:program_kegiatan][:id_subgiat]
      ProgramKegiatan.where(id_sub_giat: id_sub).update_all(programKegiatan_params.to_h.except(:row_num, :id_subgiat))
      set_program_kegiatan
      format.js do
        render "_notifikasi",
               locals: { message: "Perubahan sub kegiatan disimpan", status_icon: "success", form_name: "form-programkegiatan",
                         type: "update" }
      end
    end
  end

  def giat_update
    respond_to do |format|
      @row_num = params[:program_kegiatan][:row_num]
      id_giat = params[:program_kegiatan][:id_giat]
      ProgramKegiatan.where(id_giat: id_giat).update_all(programKegiatan_params.to_h.except(:row_num, :id_giat))
      set_program_kegiatan
      format.js do
        render "_notifikasi_giat",
               locals: { message: "Perubahan kegiatan disimpan", status_icon: "success", form_name: "form-programkegiatan",
                         type: "update" }
      end
    end
  end

  def program_update
    respond_to do |format|
      @row_num = params[:program_kegiatan][:row_num]
      id_program_sipd = params[:program_kegiatan][:id_program_sipd]
      id_giat = params[:program_kegiatan][:id_giat]
      ProgramKegiatan.where(id_program_sipd: id_program_sipd)
                     .where(id_giat: id_giat)
                     .update_all(programKegiatan_params.to_h.except(:row_num, :id_program_sipd, :id_giat))
      set_program_kegiatan
      format.js do
        render "_notifikasi_program",
               locals: { message: "Perubahan program disimpan", status_icon: "success", form_name: "form-programkegiatan",
                         type: "update" }
      end
    end
  end

  def add_isu_strategis
    @program_kegiatan = ProgramKegiatan.find(params[:id])
  end

  def create
    @programKegiatan = ProgramKegiatan.new(programKegiatan_params)
    respond_to do |format|
      if @programKegiatan.save
        format.js do
          render "_notifikasi_update",
                 locals: { message: "Program Kegiatan berhasil dibuat",
                           status_icon: "success",
                           form_name: "form-programkegiatan",
                           type: "create" }
        end
        format.html { redirect_to program_kegiatans_url, success: "Program Kegiatan Dibuat" }
      else
        format.html { render :new, error: "Gagal menyimpan Program Kegiatan" }
      end
    end
  end

  def update
    respond_to do |format|
      if @programKegiatan.update(programKegiatan_params)
        format.js do
          render "_notifikasi_update",
                 locals: { message: "Program Kegiatan berhasil diupdate",
                           status_icon: "success",
                           form_name: "form-programkegiatan",
                           type: "update" }
        end
        format.html { redirect_to program_kegiatans_url, success: "Program Kegiatan diupdate" }
      else
        format.html { render :edit, error: "Program Kegiatan Gagal diupdate" }
      end
    end
  end

  def destroy
    @programKegiatan.destroy
    respond_to do |format|
      format.html { redirect_to program_kegiatans_url, notice: "Program dihapus" }
    end
  end

  def destroy_all
    kode_opd = params[:kode_opd]
    ProgramKegiatan.where(id_sub_unit: kode_opd).destroy_all
    respond_to do |format|
      format.html { redirect_to program_kegiatans_url, notice: "Program dihapus" }
    end
  end

  private

  def set_program_kegiatan
    @programKegiatan = ProgramKegiatan.find(params[:id])
  end

  def set_dropdown
    @opds = Opd.all
  end

  def programKegiatan_params
    params.require(:program_kegiatan).permit!
  end
end
