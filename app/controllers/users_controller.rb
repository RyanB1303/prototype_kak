class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy edit_detail update_detail anggaran_sasaran]
  before_action :set_dropdown, only: %i[new edit]
  # GET /users or /users.json
  def index
    @users = User.all
  end

  def dropdown_user
    return unless current_user.has_role? :admin

    param = params[:q] || ""
    @users = current_user.opd.users.non_admin.where("nama ILIKE ?", "%#{param}%")
    respond_to do |f|
      f.json { render :index }
    end
  end

  def khusus
    @users = User.where(kode_opd: '123456890')
  end

  def struktur
    @users = User.opd_by_role(params[:opd], 'asn')
  end

  def user_search
    kode_opd = params[:kode_opd] || ''
    user_search = params[:q] || ''
    @users = User.where(kode_opd: kode_opd)
    return if user_search.empty?

    user_search.strip!
    @users = User.where(kode_opd: kode_opd).where('nama ILIKE ?',
                                                  "%#{user_search}%").or(User.where('nik ILIKE ?',
                                                                                    "%#{user_search}%"))
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  def user_admin; end

  def aktifkan_user
    @user = User.find_by(nik: params[:id])
    # @user.remove_role(:admin) if @user.has_role? :admin
    @user.remove_role :non_aktif if @user.has_role? :non_aktif
    @user.add_role(:asn) unless @user.has_role? :asn
    respond_to do |format|
      flash.now[:success] = "#{@user.nama} di aktifkan"
      format.js
    end
  end

  def nonaktifkan_user
    @user = User.find_by(nik: params[:id])
    # @user.remove_role(:admin) if @user.has_role? :admin
    @user.remove_role(:asn) if @user.has_role? :asn
    @user.add_role(:non_aktif) unless @user.has_role? :non_aktif
    # @user.has_role?(:non_aktif) ? @user.remove_role(:non_aktif) : @user.add_role(:non_aktif)
    respond_to do |format|
      flash.now[:success] = "#{@user.nama} di nonaktifkan"
      format.js
    end
  end

  def hapus_asn
    @user = User.find_by(nik: params[:id])
    @user.remove_role(:asn) if @user.has_role? :asn
    respond_to do |format|
      flash.now[:success] = "Berhasil hapus role"
      format.js { render 'nonaktifkan_user' }
    end
  end

  def nonaktifkan_semua_user
    opd = params[:opd]
    nama_opd = Opd.find_by(kode_opd: opd).nama_opd
    @asn_aktif = User.opd_by_role(opd, 'asn')
    @user_empty = User.where(kode_opd: opd).without_role(:asn).without_role(:non_aktif).without_role(:admin)
    @users = @asn_aktif + @user_empty
    @users.each { |asn| asn.nonaktifkan_user }
    respond_to do |format|
      flash.now[:success] = "Seluruh Pegawai #{nama_opd} di nonaktifkan"
      format.js { render 'shared/_notifikasi_simple' }
    end
  end

  # GET /users/1/edit
  def edit; end

  def edit_detail
    @target_render = params[:target_render]
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        params[:user][:role] && @user.add_role(params[:user][:role].to_sym)
        format.html { redirect_to adminusers_path, success: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, notice: 'Failed create user' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @user.nip_sebelum = @user.nik
    respond_to do |format|
      @user.nulify_sasaran(@user.nik)
      if @user.update(user_params)
        @user.add_role(params[:user][:role].to_sym) if params[:user][:role].present?

        format.html { redirect_to user_path(@user), success: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, notice: 'Failed update user' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_detail
    @target_render = params[:target_render]
    respond_to do |format|
      if @user.update(user_detail_params)
        if @target_render
          format.html { redirect_to @target_render, success: 'User was successfully updated.' }
        else
          format.html { redirect_to adminusers_path, success: 'User was successfully updated.' }
        end
      else
        format.html { render :edit, notice: 'Failed update user' }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to adminusers_path, success: 'User dihapus.' }
      format.json { head :no_content }
    end
  end

  def set_role
    @user = User.find(params[:id])
    @dom_id = params[:dom_id]
    @opd = @user.opd
    @roles = Role.where(name: %w[eselon_2 eselon_3 eselon_4 staff]).pluck(:name)
    @roles.insert(1, 'eselon_2b') if [145, 122, 123].include?(@opd.id)
    render partial: "form_peran"
  end

  def add_role
    @user = User.find(params[:id])
    @dom_id = params[:dom_id]
    target_role = params[:role]
    remove_role = params[:uncheck]
    checked_role = target_role.nil? ? [] : target_role & remove_role
    unchecked_role = target_role.nil? ? remove_role : (remove_role - target_role)
    if checked_role.any?
      checked_role.each do |role_add|
        @user.add_role(role_add)
      end
    end
    if unchecked_role.any?
      unchecked_role.each do |role_rem|
        @user.remove_role(role_rem)
      end
    end
    render json: { resText: "Data disimpan", result: { roles: @user.roles.pluck(:name), target: @dom_id } },
           status: :accepted
  end

  def list_all
    keyword = params[:keyword]
    @users = if keyword
               User.where("nama ILIKE ?", "%#{keyword}%")
                   .or(User.where("nik ILIKE ?", "%#{keyword}%"))
                   .or(User.where("jabatan ILIKE ?", "%#{keyword}%"))
             else
               []
             end
  end

  def edit_nip
    @user = User.find(params[:id])
    @nip = @user.nik
    render partial: "form_nip"
  end

  def update_nip
    @user = User.find(params[:id])
    @nip = params[:nip]
    @user.nip_sebelum = @user.nik
    @user.nulify_sasaran(@user.nik)
    @user.nulify_strategi(@user.nik)
    @user.nik = @nip
    @user.save
    @user.update_sasaran
    @user.update_strategi
    render json: { resText: "Data disimpan", result: { data: @nip } },
           status: :accepted
  end

  def anggaran_sasaran
    @tahun = cookies[:tahun] || Date.today.year
    @sasarans = @user.subkegiatan_sudah_lengkap(@tahun)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def set_dropdown
    @opds = Opd.all
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:nama, :nik, :password, :kode_opd, :email)
  end

  def user_detail_params
    if params[:kepala]
      params.require(:kepala).permit(:nama, :nama_bidang, :kode_opd, :jabatan)
    elsif params[:atasan]
      params.require(:atasan).permit(:nama, :nama_bidang, :kode_opd, :jabatan)
    else
      params.require(:user).permit(:nama, :nama_bidang, :kode_opd, :jabatan)
    end
  end
end
