class SubkegiatanPrioritiesController < ApplicationController
  before_action :set_subkegiatan_priority, only: %i[show edit update destroy]

  # GET /subkegiatan_priorities or /subkegiatan_priorities.json
  def index
    @subkegiatan_priorities = SubkegiatanPriority.all
  end

  def laporan_priority; end

  def cetak_pdf
    kode_priority = params[:id]
    @priorities = Sasaran.sasaran_priority(kode_priority)
    @tahun = 2023
    @nama_file = SubkegiatanPriority.find_by(kode_priority: kode_priority).nama_priority
    @waktu = Time.now.strftime("%d_%m_%Y_%H_%M")
    @filename = "Laporan_Priority_#{@nama_file}_#{@waktu}.pdf"
  end
  # GET /subkegiatan_priorities/1 or /subkegiatan_priorities/1.json
  def show; end

  # GET /subkegiatan_priorities/new
  def new
    @subkegiatan_priority = SubkegiatanPriority.new
  end

  # GET /subkegiatan_priorities/1/edit
  def edit; end

  # POST /subkegiatan_priorities or /subkegiatan_priorities.json
  def create
    @subkegiatan_priority = SubkegiatanPriority.new(subkegiatan_priority_params)

    respond_to do |format|
      if @subkegiatan_priority.save
        format.html { redirect_to @subkegiatan_priority, notice: "Subkegiatan prioritas was successfully created." }
        format.json { render :show, status: :created, location: @subkegiatan_priority }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subkegiatan_priority.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subkegiatan_priorities/1 or /subkegiatan_priorities/1.json
  def update
    respond_to do |format|
      if @subkegiatan_priority.update(subkegiatan_priority_params)
        format.html { redirect_to @subkegiatan_priority, notice: "Subkegiatan prioritas was successfully updated." }
        format.json { render :show, status: :ok, location: @subkegiatan_priority }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subkegiatan_priority.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subkegiatan_priorities/1 or /subkegiatan_priorities/1.json
  def destroy
    @subkegiatan_priority.destroy
    respond_to do |format|
      format.html { redirect_to subkegiatan_priorities_url, notice: "Subkegiatan prioritas was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subkegiatan_priority
    @subkegiatan_priority = SubkegiatanPriority.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def subkegiatan_priority_params
    params.require(:subkegiatan_priority).permit(:tahun, :nama_priority, :kode_priority)
  end
end
