class SasaranProgramOpdsController < ApplicationController
  def spip; end

  def excel_spip
    @opd = Opd.find_by(kode_unik_opd: params[:kode_unik_opd])
    @filename = "Template_import_Kota_Madiun #{@opd.nama_opd}.xlsx"
    render xlsx: "excel_spip", filename: @filename, disposition: "attachment"
  end

  def daftar_resiko
    @tahun_sasaran = cookies[:tahun_sasaran] || '2023'
    @kode_opd = current_user.opd.kode_unik_opd
    @daftar_resiko = DaftarResiko.new(kode_unik_opd: @kode_opd, tahun: @tahun_sasaran)
    @tahun_bener = @daftar_resiko.tahun
    @program_kegiatans = @daftar_resiko.daftar_resiko_asn(nip: current_user.nik)
  end

  def add_dampak_resiko
    @sasaran = Sasaran.find params[:sasaran_program_opd_id]
    @rincian = @sasaran.rincian
  end

  def cetak_daftar_resiko
    @tahun = params[:tahun] || Time.now.year
    @opd = Opd.find(params[:opd])
    @daftar_resiko = DaftarResiko.new(kode_unik_opd: @opd.kode_unik_opd, tahun: @tahun)
    @tahun_bener = @daftar_resiko.tahun
    @program_kegiatans = @daftar_resiko.daftar_resiko_opd
    # @tahun = @tahun.match(/murni/) ? @tahun[/[^_]\d*/, 0] : @tahun
    # @program_kegiatans = @opd.program_kegiatans.joins(:sasarans).where(sasarans: { tahun: @tahun }).group(:id)
    @filename = "LAPORAN_DAFTAR_RESIKO_#{@opd.nama_opd}_TAHUN_#{@tahun}.pdf"
    pdf = DaftarResikoPdf.new(opd: @opd, tahun: @tahun_bener, program_kegiatans: @program_kegiatans)
    respond_to do |format|
      format.pdf { send_data(pdf.render, filename: @filename, type: 'application/pdf', disposition: :attachment) }
      format.xlsx do
        render xlsx: "cetak_daftar_resiko", filename: @filename, disposition: 'attachment'
      end
    end
  end
end
