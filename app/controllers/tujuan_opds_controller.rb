class TujuanOpdsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_tujuan_opd, only: %i[show edit update destroy]

  # GET /tujuan_opds or /tujuan_opds.json
  def index; end

  def admin_filter
    @tahun = cookies[:tahun]
    @kode_opd = cookies[:opd]

    return if @tahun.nil?

    tahun_bener = @tahun.match(/murni|perubahan/) ? @tahun[/[^_]\d*/, 0] : @tahun
    @periode = Periode.find_tahun(tahun_bener)
    @tahun_awal = @periode.tahun_awal.to_i
    @tahun_akhir = @periode.tahun_akhir.to_i

    @opd = Opd.find_by(kode_unik_opd: @kode_opd)
    @nama_opd = @opd.nama_opd
    @tujuan_opds = @opd.tujuan_opds
                       .by_periode(tahun_bener)
    render partial: 'tujuan_opds/tujuan_opd'
  end

  # GET /tujuan_opds/1 or /tujuan_opds/1.json
  def show; end

  # GET /tujuan_opds/new
  def new
    @tahun = cookies[:tahun]
    @kode_opd = cookies[:opd]
    @opds = Opd.where.not(kode_opd: nil)
               .pluck(:nama_opd,
                      :kode_unik_opd)
    tahun_bener = @tahun.match(/murni|perubahan/) ? @tahun[/[^_]\d*/, 0] : @tahun
    @periode = Periode.find_tahun(tahun_bener)
    @tahun_awal = @periode.tahun_awal.to_i
    @tahun_akhir = @periode.tahun_akhir.to_i
    # @urusans = Master::Urusan.where(tahun: tahun_bener).collect { |urusan| [urusan.kode_nama_urusan, urusan.id] }
    # @bidang_urusans = Master::BidangUrusan.where(tahun: tahun_bener).collect do |bid_urusan|
    #   [bid_urusan.kode_nama_bidang, bid_urusan.id]
    # end
    @opd = Opd.find_by(kode_unik_opd: @kode_opd)
    @urusans = @opd.id_urusans.collect { |urusan| [urusan.kode_nama_urusan, urusan.id] }
    @bidang_urusans = @opd.id_bidang_urusans.collect { |bid_urusan| [bid_urusan.kode_nama_bidang, bid_urusan.id] }
    @tujuan_opd = TujuanOpd.new(kode_unik_opd: @kode_opd,
                                tahun_awal: @tahun_awal,
                                tahun_akhir: @tahun_akhir)
    @tujuan_opd.indikators.build.targets.build
    render layout: false
  end

  # GET /tujuan_opds/1/edit
  def edit
    @tahun = cookies[:tahun]
    @kode_opd = cookies[:opd]
    @opds = Opd.where.not(kode_opd: nil)
               .pluck(:nama_opd,
                      :kode_unik_opd)
    tahun_bener = @tahun.match(/murni|perubahan/) ? @tahun[/[^_]\d*/, 0] : @tahun
    @periode = Periode.find_tahun(tahun_bener)
    @tahun_awal = @periode.tahun_awal.to_i
    @tahun_akhir = @periode.tahun_akhir.to_i
    @opd = Opd.find_by(kode_unik_opd: @kode_opd)
    @urusans = @opd.id_urusans.collect { |urusan| [urusan.kode_nama_urusan, urusan.id] }
    @bidang_urusans = @opd.id_bidang_urusans.collect { |bid_urusan| [bid_urusan.kode_nama_bidang, bid_urusan.id] }
    render layout: false
  end

  # POST /tujuan_opds or /tujuan_opds.json
  def create
    @tujuan_opd = TujuanOpd.new(tujuan_opd_params)

    respond_to do |format|
      if @tujuan_opd.save
        format.html { redirect_to tujuan_opds_url, notice: "Sukses" }
        format.json { render :show, status: :created, location: @tujuan_opd }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tujuan_opd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tujuan_opds/1 or /tujuan_opds/1.json
  def update
    respond_to do |format|
      if @tujuan_opd.update(tujuan_opd_params)
        format.html { redirect_to tujuan_opds_url, notice: "Sukses" }
        format.json { render :show, status: :ok, location: @tujuan_opd }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tujuan_opd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tujuan_opds/1 or /tujuan_opds/1.json
  def destroy
    @tujuan_opd.destroy

    respond_to do |format|
      format.html { redirect_to tujuan_opds_url, notice: "Tujuan opd dihapus" }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tujuan_opd
    @tujuan_opd = TujuanOpd.find(params[:id])
  end

  def opd_collections
    @tahun = cookies[:tahun]
    @opds = Opd.where.not(kode_opd: nil)
               .pluck(:nama_opd,
                      :kode_unik_opd)
    @urusans = Master::Urusan.where(tahun: @tahun).collect { |urusan| [urusan.nama_urusan, urusan.id] }
    @indikators = @tujuan_opd.indikators_tujuan
  end

  # Only allow a list of trusted parameters through.
  def tujuan_opd_params
    params.require(:tujuan_opd).permit(:tujuan, :id_tujuan, :kode_unik_opd, :tahun_awal, :tahun_akhir, :urusan_id, :bidang_urusan_id,
                                       indikators_attributes)
  end

  def indikators_attributes
    { indikators_attributes: [:id, :kode, :kode_opd, :indikator, :rumus_perhitungan, :sumber_data, :_destroy,
                              targets_attributes] }
  end

  def targets_attributes
    { targets_attributes: %i[id target satuan tahun indikator_id opd_id jenis _destroy] }
  end
end
