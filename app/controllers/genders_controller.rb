class GendersController < ApplicationController
  include ErrorSerializer
  before_action :set_gender, only: %i[show edit update destroy]

  # GET /genders or /genders.json
  def index
    @genders = Gender.all
    @program_kegiatans = ProgramKegiatan.joins(:sasarans).where(sasarans: { nip_asn: current_user.nik }).group(:id)
  end

  # GET /genders/1 or /genders/1.json
  def show; end

  # GET /genders/new
  def new
    @gender = Gender.new
    @opd = current_user.opd
  end

  # GET /genders/1/edit
  def edit
    @opd = current_user.opd
  end

  # POST /genders or /genders.json
  def create
    @gender = Gender.new(gender_params)

    respond_to do |format|
      if @gender.save
        format.json do
          render json: { resText: 'Data Gender Analysis Berhasil disimpan' }, status: :created, location: @gender
        end
        format.html { redirect_to gap_genders_path, success: "Data Gender Analysis Berhasil disimpan" }
      else
        format.json { render json: ErrorSerializer.serialize(@gender.errors), status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /genders/1 or /genders/1.json
  def update
    respond_to do |format|
      if @gender.update(gender_params)
        format.html { redirect_to gap_genders_path, success: "Data Gender Analysis Berhasil diupdate" }
        format.json { render :show, status: :ok, location: @gender }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @gender.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /genders/1 or /genders/1.json
  def destroy
    @gender.destroy

    respond_to do |format|
      format.html { redirect_to gap_genders_path, success: "Data Gender Analysis dihapus" }
      format.json { head :no_content }
    end
  end

  # def gender
  #   @program_kegiatans = ProgramKegiatan.joins(:sasarans).where(sasarans: { nip_asn: current_user.nik }).group(:id)
  #   # open gender html
  # end

  def gap
    @genders = Gender.all
    render 'gap_gender'
  end

  def gbs
    @genders = Gender.all
    @program_kegiatans = ProgramKegiatan.joins(:sasarans).where(sasarans: { nip_asn: current_user.nik }).group(:id)
    render 'gbs_gender'
  end

  def pdf_gender
    # nama_file = Nama subkegiatan
    @nama_file = ProgramKegiatan.find(params[:id]).nama_subkegiatan
    @tahun = params[:tahun] || Time.now.year
    @waktu = Time.now.strftime("%d_%m_%Y_%H_%M")
    @filename = "KAK_Gender_#{@nama_file}_#{@waktu}.pdf"
    @program_kegiatan = ProgramKegiatan.find(params[:id])
    render 'kak_gender.pdf'
    # render 'pdf_gap.pdf'
  end

  def pdf_gap_gender
    @gender = Gender.find(params[:id])
    @tahun = params[:tahun]
    @opd = current_user.opd
    pdf = GapGenderPdf.new(opd: @opd, tahun: @tahun, gender: @gender)
    @filename = "GAP_#{@opd.nama_opd}_TAHUN_#{@tahun}.pdf"
    respond_to do |format|
      format.pdf { send_data(pdf.render, filename: @filename, type: 'application/pdf', disposition: :attachment) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_gender
    @gender = Gender.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def gender_params
    params.require(:gender).permit(:akses, :partisipasi, :kontrol, :manfaat,
                                   :sasaran_id, :program_kegiatan_id,
                                   :indikator, :target, :tahun,
                                   :satuan, :reformulasi_tujuan,
                                   penyebab_internal: [],
                                   penyebab_external: [],
                                   data_terpilah: [],
                                   sasaran_subkegiatan: [],
                                   rencana_aksi: [],
                                   penerima_manfaat: [])
  end
end
