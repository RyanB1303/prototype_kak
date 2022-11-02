class RenstraController < ApplicationController
  before_action :set_renstra

  def index
    # base_data = KakService.new(tahun: 2022, kode_unik_opd: @kode_unik_opd)
    # @program_kegiatans = base_data.program_kegiatans_by_opd
  end

  def admin_renstra; end

  def new
    @nama = params[:nama]
    @kode = params[:kode]
    @jenis = params[:jenis]
    @sub_jenis = params[:sub_jenis]
    @kode_indikator = params[:kode_indikator] || KodeService.new(@kode, @jenis, @sub_jenis).call
    render partial: 'form_renstra_new'
  end

  def create
    indikator_input = params[:indikator]
    keterangan = params[:keterangan]
    param_indikator = indikator_params.to_h
    @indikator = param_indikator[:indikator]
    @indikator.each do |h|
      h[:indikator] = indikator_input
      h[:keterangan] = keterangan
    end
    kode_ind = params[:_kode_indikator]
    indikator_check = Indikator.where(kode_indikator: kode_ind)
    if indikator_check.any?
      kotak = indikator_check.maximum(:kotak) + 1
      @indikator.each do |h|
        h[:kotak] = kotak
      end
    end
    indikator = Indikator.upsert_all(@indikator, returning: %w[indikator tahun target satuan pagu kotak])
    render json: { resText: 'Data disimpan', result: indikator }, status: :accepted if indikator
  end

  def edit
    @nama = params[:nama]
    @kode = params[:kode]
    @kode_opd = params[:kode_opd]
    @satuan = params[:satuan]
    @jenis = params[:jenis]
    @sub_jenis = params[:sub_jenis]
    @id = params[:id]
    @program = ProgramKegiatan.find(@id)
    @targets = @program.send("target_#{@sub_jenis.downcase}_renstra")
    @keterangan = @targets.empty? ? '' : @targets.dig("2022")[:keterangan]
    @kode_indikator = params[:kode_indikator] || KodeService.new(@kode, @jenis, @sub_jenis).call
    render partial: 'form_renstra'
  end

  def update_programs
    # indikator_input = params[:indikator]
    keterangan = params[:keterangan]
    param_indikator = indikator_params.to_h
    @indikator = param_indikator[:indikator]
    @indikator.each do |h|
      # h[:indikator] = indikator_input
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
    indikator = Indikator.upsert_all(@indikator, returning: %w[indikator tahun target satuan pagu])
    render json: { resText: 'Data disimpan', result: indikator }, status: :accepted if indikator
  end

  def set_renstra
    @kode_unik_opd = params[:kode_unik_opd]
    @tahun = params[:tahun]
  end

  private

  def renstra_params
    params.require(:program_kegiatan)
          .permit(:nama_subkegiatan, :tahun, :target_subkegiatan, :indikator_subkegiatan)
  end

  def indikator_params
    params.require(:renstra).permit(indikator: %i[indikator tahun satuan kode jenis sub_jenis target pagu keterangan
                                                  kode_opd kode_indikator kotak])
  end
end
