class ManualIksController < ApplicationController
  before_action :set_indikator, only: %i[show create edit update destroy]
  before_action :set_manual_ik, only: %i[show edit update destroy]

  # GET /manual_iks or /manual_iks.json
  def index
    @manual_iks = ManualIk.all
  end

  # GET /manual_iks/1 or /manual_iks/1.json
  def show
    @sasaran = @indikator.sasaran
    @user = @sasaran.user
  end

  # GET /manual_iks/new
  def new
    set_indikator
    @sasaran = @indikator.sasaran
    @user = @sasaran.user
    @manual_ik = @indikator.build_manual_ik
  end

  # GET /manual_iks/1/edit
  def edit; end

  # POST /manual_iks or /manual_iks.json
  def create
    # @manual_ik = ManualIk.new(manual_ik_params)
    @manual_ik = @indikator.build_manual_ik(manual_ik_params)

    respond_to do |format|
      if @manual_ik.save
        format.html do
          redirect_to indikator_sasaran_manual_ik_path(@indikator, @manual_ik),
                      notice: "Manual ik was successfully created."
        end
        format.json { render :show, status: :created, location: @manual_ik }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @manual_ik.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manual_iks/1 or /manual_iks/1.json
  def update
    respond_to do |format|
      if @manual_ik.update(manual_ik_params)
        format.html { redirect_to manual_ik_url(@manual_ik), notice: "Manual ik was successfully updated." }
        format.json { render :show, status: :ok, location: @manual_ik }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @manual_ik.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manual_iks/1 or /manual_iks/1.json
  def destroy
    @manual_ik.destroy

    respond_to do |format|
      format.html { redirect_to manual_iks_url, notice: "Manual ik was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_manual_ik
    @manual_ik = ManualIk.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_sasaran
    @sasaran = Sasaran.find(params[:sasaran_id])
  end

  def set_indikator
    @indikator = IndikatorSasaran.find(params[:indikator_sasaran_id])
  end

  # Only allow a list of trusted parameters through.
  def manual_ik_params
    params.require(:manual_ik).permit(:perspektif, :rhk, :tujuan_rhk, :indikator_kinerja, :target, :satuan,
                                      :definisi, :key_activities, :key_milestone, :formula, :jenis_indikator,
                                      :penanggung_jawab, :penyedia_data, :sumber_data, :mulai, :akhir, :periode_pelaporan,
                                      :budget)
  end
end
