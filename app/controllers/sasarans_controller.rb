class SasaransController < ApplicationController
  before_action :get_user, only: %i[index new create update destroy]
  before_action :set_sasaran, only: %i[show edit update destroy update_program_kegiatan renaksi_update detail]
  before_action :set_dropdown, only: %i[new edit]

  # GET /sasarans or /sasarans.json
  def index
    @tahun_sasaran = cookies[:tahun_sasaran] || nil
    @sasarans = @user.sasarans.where(tahun: @tahun_sasaran).order(:id)
    @sasarans = @user.sasarans.order(:id) if @sasarans.empty?
    if current_user.has_role? :admin
      @sasarans = @user.opd.sasarans.includes(:indikator_sasarans).order(:id)
      render 'index_admin'
    end
  end

  def list_sasaran
    param = params[:q] || ""
    @opd = current_user.opd
    # we do the complex logic for simple thing here
    @sasarans = @opd.sasarans.dengan_rincian.merge(@opd.users.asn_aktif).where("sasaran_kinerja ILIKE ?", "%#{param}%").limit(50)
  end

  def data_detail
    @sasaran = Sasaran.find(params[:id])
    respond_to do |format|
      format.html { render partial: 'templates/data_pembuka_wawasan_card', locals: { sasaran: @sasaran } }
      format.json
    end
  end

  def rencana_aksi
    @sasaran = Sasaran.find(params[:id])
    render partial: 'templates/rencana_aksi_card', locals: { sasaran: @sasaran }
  end

  # GET /sasarans/1 or /sasarans/1.json
  def show; end

  def laporan_kak(tahun: '')
    @program_kegiatans = ProgramKegiatan.joins(:sasarans).where(sasarans: { nip_asn: current_user.nik,
                                                                            tahun: tahun }).group(:id)
    @jumlah_sasaran = ProgramKegiatan.joins(:sasarans).where(sasarans: { nip_asn: current_user.nik,
                                                                         tahun: tahun }).count(:sasarans)
    @jumlah_subkegiatan = ProgramKegiatan.includes(:sasarans).where(sasarans: { nip_asn: current_user.nik,
                                                                                tahun: tahun }).count
    @jumlah_usulan = ProgramKegiatan.includes(:sasarans).where(sasarans: { nip_asn: current_user.nik,
                                                                           tahun: tahun }).map do |program|
      program.sasarans.where(tahun: tahun).map do |s|
        s.usulans.count
      end.reduce(:+)
    end.reduce(:+)
    @total_pagu = @program_kegiatans.map do |program|
      program.sasarans.where(tahun: tahun).sudah_lengkap.map(&:total_anggaran).compact.sum
    end.sum
    @sasarans = Sasaran.sudah_lengkap.where(nip_asn: current_user.nik).where(tahun: tahun)
  end

  def detail
    @program_kegiatan = @sasaran.program_kegiatan
  end

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
    flash.now[:success] = 'Perhitungan Renaksi Berhasil'
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
    render 'shared/_notifier_v2',
           locals: { message: 'Sasaran berhasil diajukan', status_icon: 'success', form_name: 'non-exists' }
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
      flash.now[:info] = 'Kuncian Dibuka'
      @status = 'warning'
      @type = 'revisi'
      @text = 'Kuncian Dibuka'
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
    # @sasaran = Sasaran.find(params[:id])
    # @sasaran.update(status: 'disetujui')
    # render 'shared/_notifier_v2', locals: { message: 'Sasaran disetujui', status_icon: 'success', form_name: 'non-exists' }
    @sasaran = params[:id]
    Sasaran.find(@sasaran).update(status: 'disetujui')
    respond_to do |format|
      @rowspan = params[:rowspan]
      @dom = params[:dom]
      flash.now[:success] = ['Rencana Kinerja dikunci', 'dikunci']
      @status = 'dikunci'
      @type = 'setuju'
      @text = 'Rencana Kinerja dikunci'
      format.js { render 'update_kak.js.erb' }
    end
  end

  def tolak
    @sasaran = Sasaran.find(params[:id])
    @sasaran.update(status: 'ditolak')
    render 'shared/_notifier_v2', locals: { message: 'Sasaran ditolak', status_icon: 'info', form_name: 'non-exists' }
  end

  def revisi
    # @sasaran = Sasaran.find(params[:id])
    # @sasaran.update(status: 'draft')
    # render 'shared/_notifier_v2', locals: { message: 'Revisi', status_icon: 'warning', form_name: 'non-exists' }
    @sasaran = params[:id]
    Sasaran.find(@sasaran).update(status: 'draft')
    respond_to do |format|
      @rowspan = params[:rowspan]
      @dom = params[:dom]
      flash.now[:info] = ['Rencana Kinerja dibuka', 'dibuka']
      @status = 'dibuka'
      @type = 'revisi'
      @text = 'Rencana Kinerja dibuka'
      format.js { render 'update_kak.js.erb' }
    end
  end

  def clone
    # TODO: CLEAN THIS UP
    @sasaran = params[:id]
    kelompok_anggaran = KelompokAnggaran.find(sasaran_params[:kelompok_anggaran])
    sasaran_target = Sasaran.find(@sasaran)
    sasaran_target.class.amoeba do
      set tahun: kelompok_anggaran.kode_tahun_sasaran
      append id_rencana: kelompok_anggaran.kode_kelompok
    end
    duplicate = sasaran_target.amoeba_dup
    respond_to do |format|
      @rowspan = params[:rowspan]
      @dom = params[:dom]
      if duplicate.save
        sasaran_target.indikator_sasarans.map do |is|
          is.class.amoeba do
            append sasaran_id: kelompok_anggaran.kode_kelompok
            append id_indikator: kelompok_anggaran.kode_kelompok
          end
          is.amoeba_dup.save
        end
        sasaran_target.dasar_hukums.map do |ds|
          ds.class.amoeba do
            append sasaran_id: kelompok_anggaran.kode_kelompok
          end
          ds.amoeba_dup.save
        end
        sasaran_target.tahapans.map do |tahap|
          tahap.class.amoeba do
            append id_rencana: kelompok_anggaran.kode_kelompok
            append id_rencana_aksi: kelompok_anggaran.kode_kelompok
          end
          tahap.amoeba_dup.save
          tahap.aksis.map do |th|
            th.class.amoeba do
              append id_aksi_bulan: kelompok_anggaran.kode_kelompok
              append id_rencana_aksi: kelompok_anggaran.kode_kelompok
            end
            th.amoeba_dup.save
          end
        end
        flash.now[:success] = ['Berhasil di cloning', 'dicloning']
        @type = 'berhasil'
        @text = 'Berhasil dicloning'
      else
        flash.now[:danger] = ['Gagal di cloning', 'gagal']
        @type = 'gagal'
        @text = 'gagal dicloning'
      end
      format.js { render 'update_kak' }
    end
  end

  def clone_form
    @sasaran = Sasaran.find(params[:id])
  end

  # GET /sasarans/new
  def new
    @sasaran = @user.sasarans.build
    @tipe = params[:tipe]
    @sasaran.indikator_sasarans.build
  end

  # GET /sasarans/1/edit
  def edit
    @tipe = params[:tipe]
  end

  # POST /sasarans or /sasarans.json
  def create
    @sasaran = @user.sasarans.build(sasaran_params)
    # @sasaran.id_rencana = (SecureRandom.random_number(9e5) + 1e5).to_i # This method will bites back, look up in here
    respond_to do |format|
      if @sasaran.save
        # @sasaran.indikator_sasarans.create!(sasaran_params[:indikator_sasarans_attributes].merge!(sasaran_id: sasaran_params[:id_rencana]))
        # format.html { redirect_to user_sasaran_path(@user, @sasaran), success: 'Sasaran berhasil dibuat.' }
        format.html { redirect_to sasarans_path, success: 'Sasaran berhasil dibuat.' }
        format.json { render :show, status: :created, location: @sasaran }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sasaran.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sasarans/1 or /sasarans/1.json
  def update
    # @sasaran = @user.sasarans.find(params[:id])
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
        # format.html { redirect_to user_sasaran_path(@user, @sasaran) }
        format.html { redirect_to sasarans_path, success: 'Sasaran diupdate.' }
        format.json { render :show, status: :ok, location: @sasaran }
      else
        flash.now[:error] = 'Sasaran gagal update.'
        format.js
        # format.html { redirect_to user_sasaran_path(@user, @sasaran), error: 'Sasaran gagal update.' }
        format.html { redirect_to sasarans_path, success: 'Sasaran gagal diupdate' }
        format.json { render json: @sasaran.errors, status: :unprocessable_entity }
      end
    end
  end

  def pilih_asn
    @sasaran = Sasaran.find(params[:id])
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
        # format.html { redirect_to user_sasaran_path(@user, @sasaran) }
        format.html { redirect_to sasarans_path, success: 'Sasaran diupdate.' }
        format.json { render :show, status: :ok, location: @sasaran }
      else
        flash.now[:error] = 'Sasaran gagal update.'
        format.js
        # format.html { redirect_to user_sasaran_path(@user, @sasaran), error: 'Sasaran gagal update.' }
        format.html { redirect_to sasarans_path, success: 'Sasaran gagal diupdate' }
        format.json { render json: @sasaran.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sasarans/1 or /sasarans/1.json
  def destroy
    @sasaran.destroy
    respond_to do |format|
      format.html { redirect_to sasarans_path, success: 'Sasaran berhasil dihapus' }
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
    params.require(:sasaran).permit(:sasaran_kinerja, :penerima_manfaat, :nip_asn, :program_kegiatan_id,
                                    :sumber_dana, :subkegiatan_tematik_id, :tahun, :id_rencana,
                                    :kelompok_anggaran, :filter_file, :filter_target, :filter_type, :sasaran_milik,
                                    indikator_sasarans_attributes: %i[id indikator_kinerja aspek target satuan _destroy])
  end

  rescue_from ActionController::ParameterMissing do
    render 'shared/_notifier', locals: { message: 'isian belum terisi' }, status: :unprocessable_entity
  end
end
