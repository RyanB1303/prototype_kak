class RenstraController < ApplicationController
  before_action :set_renstra
  layout false, only: %i[laporan]

  def index
    # base_data = KakService.new(tahun: 2022, kode_unik_opd: @kode_unik_opd)
    # @program_kegiatans = base_data.program_kegiatans_by_opd
    @periode = params[:periode]
  end

  def admin_renstra; end

  def edit
    form_edit_attr
    render partial: 'form_renstra'
  end

  def edit_realisasi
    form_edit_attr
    render partial: 'form_realisasi'
  end

  def update_programs
    # indikator_input = params[:indikator]
    @tahun_awal = params[:tahun_awal]
    @tahun_akhir = params[:tahun_akhir]
    nomor = params[:nomor]
    sub_jenis = params[:sub_jenis].downcase
    kode_opd = params[:kode_opd]
    periode = (@tahun_awal..@tahun_akhir)

    program = ProgramKegiatan.find(params[:id])
    keterangan = params[:keterangan]

    param_indikator = indikator_params.to_h
    @indikator = param_indikator[:indikator]
    @indikator.each do |h|
      h[:keterangan] = keterangan
    end
    kode_ind = params[:_kode_indikator]
    indikator_check = Indikator.where(kode_indikator: kode_ind)
    if indikator_check.any?
      versi = indikator_check.maximum(:version) + 1
      @indikator.each do |h|
        h[:version] = versi
      end
    end
    # update / insert to database
    Indikator.upsert_all(@indikator)

    # decide partial and indikators fetch
    case sub_jenis
    when 'program'
      partial = 'renstra/program_renstra'
      indikators = program.indikator_renstras_new('program', kode_opd)[:indikator_program]
    when 'kegiatan'
      partial = 'renstra/kegiatan_renstra'
      indikators = program.indikator_renstras_new('kegiatan', kode_opd)[:indikator_kegiatan]
    else
      partial = 'renstra/subkegiatan_renstra'
      indikators = program.indikator_renstras_new('subkegiatan', kode_opd)[:indikator_subkegiatan]
    end
    render json: { resText: 'Data disimpan',
                   html_content: html_content({ periode: periode,
                                                nomor: nomor,
                                                program: program,
                                                indikators: indikators },
                                              partial: partial) }.to_json,
           status: :accepted
  end

  def laporan
    @kode_opd = cookies[:opd]
    @tahun = cookies[:tahun]
    periode = params[:periode].split('-')
    @tahun_awal = periode[0].to_i
    @tahun_akhir = periode[-1].to_i
    @periode = (@tahun_awal..@tahun_akhir)
    @colspan = (@periode.size * 5) + 3
    @opd = Opd.find_by(kode_unik_opd: @kode_opd)
    @nama_opd = @opd.nama_opd
    program_renstra = @opd.program_renstra
    if @tahun_awal == 2025
      @list_subkegiatans = @opd.sasaran_subkegiatans(@tahun_awal)
      @kode_subs = @list_subkegiatans.to_h { |sub| [sub.kode_sub_giat, 0] }
    else
      @kode_subs = @opd.program_kegiatans.to_h { |sub| [sub.kode_sub_giat, 0] }
    end
    program_kegiatan_by_urusans = program_renstra.group_by do |prg|
      [prg.kode_urusan, prg.nama_urusan]
    end
    @program_kegiatans = program_kegiatan_by_urusans.transform_values do |prg_v1|
      prg_v1.group_by { |prg| [prg.kode_bidang_urusan, prg.nama_bidang_urusan] }
    end
  end

  def renstra_cetak
    @title = "Rawnal Renja"
    @tahun_awal = params[:tahun_awal]
    @tahun_akhir = params[:tahun_akhir]
    renstra = RenstraQueries.new(kode_opd: @kode_unik_opd, tahun_awal: @tahun_awal, tahun_akhir: @tahun_akhir)
    @program_kegiatans = renstra.program_kegiatan_renstra
    @periode = renstra.periode
    respond_to do |format|
      format.html
    end
  end

  private

  def set_renstra
    @kode_unik_opd = params[:kode_unik_opd]
    @tahun = params[:tahun]
  end

  def form_edit_attr
    @nama = params[:nama]
    @kode = params[:kode]
    @kode_opd = params[:kode_opd]
    @satuan = params[:satuan]
    @jenis = params[:jenis]
    @sub_jenis = params[:sub_jenis]
    @tahun_awal = params[:tahun_awal]
    @tahun_akhir = params[:tahun_akhir]
    @periode = (params[:tahun_awal]..params[:tahun_akhir])
    @nomor = params[:nomor]
    @program = ProgramKegiatan.find(params[:id])
    @targets = @program.send("target_#{@sub_jenis.downcase}_renstra")
    @kode_indikator = params[:kode_indikator] || KodeService.new(@kode, @jenis, @sub_jenis).call
    @dom_target = helpers.dom_id(@program, @sub_jenis)
  end

  def renstra_params
    params.require(:program_kegiatan)
          .permit(:nama_subkegiatan, :tahun, :target_subkegiatan, :indikator_subkegiatan)
  end

  def indikator_params
    params.require(:renstra).permit(indikator: %i[indikator tahun satuan kode jenis sub_jenis target pagu keterangan
                                                  kode_opd kode_indikator realisasi realisasi_pagu])
  end
end
