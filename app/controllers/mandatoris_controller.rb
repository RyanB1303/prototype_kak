class MandatorisController < ApplicationController
  before_action :set_mandatori, only: %i[show edit update destroy]

  # GET /mandatoris or /mandatoris.json
  def index
    @tahun = cookies[:tahun] || Date.current.year.to_s
    kode_opd = Opd.find_by(kode_unik_opd: cookies[:opd]).kode_opd
    @mandatoris = Mandatori.includes(:user).where(user: { kode_opd: kode_opd }, tahun: @tahun)
  end

  # TODO: refactor, violating rails principle
  def usulan_mandatori
    @tahun = cookies[:tahun] || Date.current.year.to_s
    @mandatoris = Mandatori.where(nip_asn: current_user.nik, tahun: @tahun).order(:created_at)
    render 'user_mandatori'
  end

  def spbe
    @tahun = cookies[:tahun] || Date.current.year.to_s
    @mandatoris = SasaranSpbe.where(tahun: @tahun)
  end

  # GET /mandatoris/1 or /mandatoris/1.json
  def show; end

  # GET /mandatoris/new
  def new
    user = current_user.nik
    opd = Opd.find_by_kode_unik_opd cookies[:opd]
    tahun = cookies[:tahun]
    @mandatori = Mandatori.new(tahun: tahun, nip_asn: user, opd: opd)
    render layout: false
  end

  # GET /mandatoris/1/edit
  def edit
    render layout: false
  end

  # POST /mandatoris or /mandatoris.json
  def create
    form_params = mandatori_params.merge(is_active: true, status: 'disetujui')
    @mandatori = Mandatori.new(form_params)

    if @mandatori.save
      render json: { resText: "Entri Mandatori ditambahkan",
                     html_content: html_content({ mandatori: @mandatori },
                                                partial: 'mandatoris/mandatori') }.to_json,
             status: :ok
    else
      render json: { resText: "Terjadi kesalahan",
                     html_content: error_content({ mandatori: @mandatori },
                                                 partial: 'mandatoris/form') }.to_json,
             status: :unprocessable_entity
    end
  end

  # PATCH/PUT /mandatoris/1 or /mandatoris/1.json
  def update
    if @mandatori.update(mandatori_params)
      render json: { resText: "Perubahan tersimpan",
                     html_content: html_content({ mandatori: @mandatori },
                                                partial: 'mandatoris/mandatori') }.to_json,
             status: :ok
    else
      render json: { resText: "Terjadi kesalahan",
                     html_content: error_content({ mandatori: @mandatori },
                                                 partial: 'mandatori/form') }.to_json,
             status: :unprocessable_entity
    end
  end

  def edit_renstra
    @mandatori = Mandatori.find(params[:id])
    render layout: false
  end

  def update_renstra
    @mandatori = Mandatori.find(params[:id])
    if @mandatori.update(mandatori_params)
      render json: { resText: "Perubahan tersimpan",
                     html_content: html_content({ mandatori: @mandatori },
                                                partial: 'mandatoris/mandatori_renstra') }.to_json,
             status: :ok
    else
      render json: { resText: "Terjadi kesalahan",
                     html_content: error_content({ mandatori: @mandatori },
                                                 partial: 'mandatori/form_row') }.to_json,
             status: :unprocessable_entity
    end
  end

  # DELETE /mandatoris/1 or /mandatoris/1.json
  def destroy
    @mandatori.destroy
    render json: { resText: "Usulan mandatori Dihapus", result: true }
  end

  def toggle_is_active
    @mandatori = Mandatori.find(params[:id])
    respond_to do |format|
      if @mandatori.update(status: 'disetujui')
        @mandatori.toggle! :is_active
        flash.now[:success] = 'Usulan diaktifkan'
        format.js { render 'toggle_is_active' }
      else
        flash.now[:alert] = 'Gagal Mengaktifkan'
        format.js { :unprocessable_entity }
      end
    end
  end

  def setujui_usulan_di_sasaran
    @mandatori = Mandatori.find(params[:id])
    respond_to do |format|
      if @mandatori.update(status: 'disetujui')
        @mandatori.toggle! :is_active
        flash.now[:success] = 'Usulan disetujui'
        format.js { render 'toggle_is_active' }
      else
        flash.now[:alert] = 'Gagal Mengaktifkan'
        format.js { :unprocessable_entity }
      end
    end
  end

  def mandatori_search
    tahun = cookies[:tahun] || Date.current.year.to_s
    param = params[:q] || ''
    @mandatoris = Search::AllUsulan
                  .where(
                    "searchable_type = 'Mandatori' and sasaran_id is null and usulan ILIKE ?", "%#{param}%"
                  )
                  .where(searchable: Mandatori.where(nip_asn: current_user.nik, tahun: tahun))
                  .order(searchable_id: :desc)
                  .includes(:searchable)
                  .collect(&:searchable)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_mandatori
    @mandatori = Mandatori.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def mandatori_params
    params.require(:mandatori).permit!
  end
end
