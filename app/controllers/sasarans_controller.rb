class SasaransController < ApplicationController
  before_action :get_user, only: %i[index new create update destroy]
  before_action :set_sasaran, only: %i[show edit update destroy update_program_kegiatan renaksi_update]
  before_action :set_dropdown, only: %i[new edit]

  # GET /sasarans or /sasarans.json
  def index
    @sasarans = @user.sasarans
  end

  # GET /sasarans/1 or /sasarans/1.json
  def show; end

  def sasaran_admin; end

  def daftar_subkegiatan
    @sasarans = Sasaran.includes(:program_kegiatan).where.not(program_kegiatan: { id: nil })
  end

  def pdf_daftar_subkegiatan; end

  def hapus_program_from_sasaran
    param_id = params[:id_sasaran]
    sasaran = Sasaran.find(param_id)
    respond_to do |format|
      if sasaran.update(program_kegiatan_id: nil)
        @status = 'success'
        @text = 'Sukses menghapus program kegiatan'
        format.js
      else
        @status = 'error'
        @text = 'Terjadi kesalahan saat menghapus program kegiatan'
        format.js :unprocessable_entity
      end
    end
  end

  def hapus_tematik_from_sasaran
    id_sasaran = params[:id_sasaran]
    id_tematik = params[:id_tematik]
    TematikSasaran.where(sasaran_id: id_sasaran, subkegiatan_tematik_id: id_tematik).first.destroy
    respond_to do |format|
      @status = 'success'
      @text = 'Sukses menghapus tematik'
      format.js { render :hapus_program_from_sasaran }
    end
  end

  def add_sasaran_tematik
    sasaran = Sasaran.find(params[:id_sasaran])
    tematik = params[:id_tematik]
    respond_to do |format|
      if sasaran.add_tematik(sasaran: sasaran.id, tematik: tematik)
        @status = 'success'
        @text = 'Sukses menambah tematik'
        format.js { render :hapus_program_from_sasaran }
      else
        @status = 'error'
        @text = 'Terjadi kesalahan saat menambah tematik'
        format.js { render :hapus_program_from_sasaran, :unprocessable_entity }
      end
    end
  end

  def renaksi_update
    @sasaran.sync_total_renaksi
  end

  def laporan_sasaran
    @sasarans = User.asn_aktif.where(kode_opd: current_user.kode_opd)
  end

  def verifikasi_sasaran
    @sasarans = Sasaran.where.not(status: 'draft').select do |s|
      s.user.opd.id_opd_skp == current_user.opd.id_opd_skp or current_user.has_role? :super_admin
    end
  end

  def ajukan_semua_sasaran
    sasarans = params[:sasaran_diajukans]
    Sasaran.where(id: sasarans).update_all(status: 'pengajuan')
    respond_to do |format|
      flash[:success] = 'KaK Diajukan'
      @status = 'success'
      @text = 'KaK Berhasil Diajukan'
      format.js { render 'update.js.erb' }
    end
  end

  def ajukan_verifikasi
    @sasaran = Sasaran.find(params[:id])
    @sasaran.update(status: 'pengajuan')
    render 'shared/_notifier_v2', locals: { message: 'Sasaran berhasil diajukan', status_icon: 'success', form_name: 'non-exists' }
  end

  def setujui_semua_sasaran
    @sasarans = params[:sasaran_diajukans]
    respond_to do |format|
      @rowspan = params[:rowspan]
      @dom = params[:dom]
      flash.now[:success] = 'KaK disetujui'
      Sasaran.where(id: @sasarans.flatten!).update_all(status: 'disetujui')
      @status = 'success'
      @type = 'setuju'
      @text = 'KaK Berhasil Disetujui'
      format.js { render 'update_kak.js.erb' }
    end
  end

  def revisi_semua_sasaran
    @sasarans = params[:sasaran_diajukans]
    Sasaran.where(id: @sasarans.flatten!).update_all(status: 'draft')
    respond_to do |format|
      @rowspan = params[:rowspan]
      @dom = params[:dom]
      flash.now[:info] = 'KaK direvisi'
      @status = 'warning'
      @type = 'revisi'
      @text = 'KaK direvisi'
      format.js { render 'update_kak.js.erb' }
    end
  end

  def tolak_semua_sasaran
    @sasarans = params[:sasaran_diajukans]
    Sasaran.where(id: @sasarans.flatten!).update_all(status: 'ditolak')
    respond_to do |format|
      @rowspan = params[:rowspan]
      @dom = params[:dom]
      flash.now[:warning] = 'KaK ditolak'
      @status = 'warning'
      @type = 'ditolak'
      @text = 'KaK ditolak'
      format.js { render 'update_kak.js.erb' }
    end
  end

  def setujui
    @sasaran = Sasaran.find(params[:id])
    @sasaran.update(status: 'disetujui')
    render 'shared/_notifier_v2', locals: { message: 'Sasaran disetujui', status_icon: 'success', form_name: 'non-exists' }
  end

  def tolak
    @sasaran = Sasaran.find(params[:id])
    @sasaran.update(status: 'ditolak')
    render 'shared/_notifier_v2', locals: { message: 'Sasaran ditolak', status_icon: 'info', form_name: 'non-exists' }
  end

  def revisi
    @sasaran = Sasaran.find(params[:id])
    @sasaran.update(status: 'draft')
    render 'shared/_notifier_v2', locals: { message: 'Revisi', status_icon: 'warning', form_name: 'non-exists' }
  end

  # GET /sasarans/new
  def new
    @sasaran = @user.sasarans.build
    @sasaran.build_rincian
  end

  # GET /sasarans/1/edit
  def edit
    @sasaran.build_rincian if @sasaran.rincian.nil?
  end

  # POST /sasarans or /sasarans.json
  def create
    @sasaran = @user.sasarans.build(sasaran_params)
    @sasaran.id_rencana = SecureRandom.base36(6)
    respond_to do |format|
      if @sasaran.save
        format.html { redirect_to user_sasaran_path(@user, @sasaran), notice: 'Sasaran was successfully created.' }
        format.json { render :show, status: :created, location: @sasaran }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sasaran.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sasarans/1 or /sasarans/1.json
  def update
    respond_to do |format|
      if @sasaran.update(sasaran_params)
        flash[:success] = if sasaran_params[:program_kegiatan_id]
                            'Sukses menambah subkegiatan'
                          elsif sasaran_params[:sumber_dana]
                            'Sumber dana disimpan'
                          else
                            'Sukses update sasaran'
                          end
        @status = 'success'
        @text = 'Sukses menambah tematik'
        format.js { render 'update.js.erb' }
        format.html { redirect_to user_sasaran_path(@user, @sasaran) }
        format.json { render :show, status: :ok, location: @sasaran }
      else
        flash.now[:error] = 'Sasaran gagal update.'
        format.js
        format.html { redirect_to user_sasaran_path(@user, @sasaran), error: 'Sasaran gagal update.' }
        format.json { render json: @sasaran.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sasarans/1 or /sasarans/1.json
  def destroy
    @sasaran.destroy
    respond_to do |format|
      format.html { redirect_to sasarans_path, notice: 'Sasaran was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def get_user
    @user = current_user
  end

  def get_program_kegiatan
    @program_kegiatan = ProgramKegiatan.find(params[:program_kegiatan_id])
  end

  def set_sasaran
    @sasaran = Sasaran.find(params[:id])
  end

  def set_dropdown
    @users = User.all
  end

  # Only allow a list of trusted parameters through.
  def sasaran_params
    params.require(:sasaran).permit(:sasaran_kinerja, :indikator_kinerja, :target, :kualitas,
                                    :satuan, :penerima_manfaat, :nip_asn, :program_kegiatan_id,
                                    :sumber_dana, :subkegiatan_tematik_id)
  end

  rescue_from ActionController::ParameterMissing do
    render 'shared/_notifier', locals: { message: 'isian belum terisi' }, status: :unprocessable_entity
  end
end
