class FilterController < ApplicationController
  before_action :filter_params, except: %i[filter_tematiks]
  before_action :nama_opd, only: %i[filter_gender filter_struktur]

  OPD_TABLE = {
    'Dinas Kesehatan, Pengendalian Penduduk dan Keluarga Berencana': 'Dinas Kesehatan',
    'Rumah Sakit Umum Daerah Kota Madiun': 'Rumah Sakit Umum Daerah',
    'Sekretariat Daerah': 'Sekretaris Daerah',
    'Bagian Umum': 'Bagian Umum',
    'Bagian Pengadaan Barang/Jasa dan Administrasi Pembangunan': 'Bagian Pengadaan Barang/Jasa dan Administrasi Pembangunan',
    'Bagian Organisasi': 'Bagian Organisasi',
    'Bagian Hukum': 'Bagian Hukum',
    'Bagian Perekonomian dan Kesejahteraan Rakyat': 'Bagian Perekonomian dan Kesejahteraan Rakyat',
    'Bagian Pemerintahan': 'Bagian Pemerintahan'
  }.freeze

  KODE_OPD_TABLE = {
    'Dinas Kesehatan, Pengendalian Penduduk dan Keluarga Berencana': '1.02.2.14.0.00.03.0000',
    'Rumah Sakit Umum Daerah Kota Madiun': '1.02.2.14.0.00.03.0000',
    'Sekretariat Daerah': '4.01.0.00.0.00.01.00', # don't change, this still used
    'Bagian Umum': '4.01.0.00.0.00.01.00',
    'Bagian Pengadaan Barang/Jasa dan Administrasi Pembangunan': '4.01.0.00.0.00.01.00',
    'Bagian Organisasi': '4.01.0.00.0.00.01.00',
    'Bagian Hukum': '4.01.0.00.0.00.01.00',
    'Bagian Perekonomian dan Kesejahteraan Rakyat': '4.01.0.00.0.00.01.00',
    'Bagian Pemerintahan': '4.01.0.00.0.00.01.00'
  }.freeze

  KODE_OPD_BAGIAN = {
    'Dinas Kesehatan, Pengendalian Penduduk dan Keluarga Berencana': '448',
    'Rumah Sakit Umum Daerah Kota Madiun': '3408',
    'Sekretariat Daerah': '479', # don't change, this still used
    'Bagian Umum': '4402',
    'Bagian Pengadaan Barang/Jasa dan Administrasi Pembangunan': '4400',
    'Bagian Organisasi': '4398',
    'Bagian Hukum': '4399',
    'Bagian Perekonomian dan Kesejahteraan Rakyat': '4401',
    'Bagian Pemerintahan': '4397'
  }.freeze

  def filter_sasaran
    opd = Opd.find_by(kode_opd: @kode_opd).nama_opd
    @nama_opd ||= Opd.find_by(kode_opd: @kode_opd).nama_opd || '-'
    @sasarans = Sasaran.includes([user: :opd]).where(opds: { kode_opd: @kode_opd }).where(nip_asn: params[:nip_asn])
    if OPD_TABLE.key?(opd.to_sym)
      @sasarans = Sasaran.includes([user: :opd]).where(opds: { kode_unik_opd: KODE_OPD_TABLE[opd.to_sym] })
      @sasarans = @sasarans.where(user: { nama_bidang: OPD_TABLE[opd.to_sym] })
    end
    respond_to do |format|
      format.js { render 'sasarans/sasaran_filter' }
    end
  end

  def filter_user # FIXME: jika tidak ada bidang pada opd table, user tidak akan tampil
    opd = Opd.find_by(kode_unik_opd: @kode_opd).nama_opd
    @users = User.includes([:opd]).where(opds: { kode_unik_opd: @kode_opd })
    if OPD_TABLE.key?(opd.to_sym)
      @users = User.includes([:opd]).where(opds: { kode_unik_opd: KODE_OPD_TABLE[opd.to_sym] })
                   .where(nama_bidang: OPD_TABLE[opd.to_sym])
    end
    @filter_file = 'hasil_filter' if params[:filter_file].empty?
    respond_to do |format|
      format.js { render 'users/user_filter' }
    end
  end

  # filter subkegiatan
  def filter_program
    opd = Opd.find_by(kode_unik_opd: @kode_opd).nama_opd
    @programKegiatans = ProgramKegiatan.order(:id).includes(%i[opd]).where(opds: { kode_unik_opd: @kode_opd })
    if OPD_TABLE.key?(opd.to_sym)
      @programKegiatans = ProgramKegiatan.order(:id).includes(%i[opd]).where(id_sub_unit: KODE_OPD_BAGIAN[opd.to_sym])
    end
    respond_to do |format|
      @render_file = 'program_kegiatans/hasil_filter'
      format.js { render 'program_kegiatans/program_kegiatan_filter' }
    end
  end

  def filter_program_saja
    opd = Opd.find_by(kode_unik_opd: @kode_opd).nama_opd
    @programKegiatans = ProgramKegiatan.includes(:opd).select("DISTINCT ON(program_kegiatans.kode_giat) program_kegiatans.*").where(opds: { kode_unik_opd: @kode_opd })
    if OPD_TABLE.key?(opd.to_sym)
      @programKegiatans = ProgramKegiatan.includes(:opd).select("DISTINCT ON(program_kegiatans.kode_giat) program_kegiatans.*").where(id_sub_unit: KODE_OPD_BAGIAN[opd.to_sym])
    end
    respond_to do |format|
      @render_file = 'program_kegiatans/hasil_filter_program'
      format.js { render 'program_kegiatans/program_kegiatan_filter' }
    end
  end

  def filter_kegiatan
    opd = Opd.find_by(kode_unik_opd: @kode_opd).nama_opd
    @programKegiatans = ProgramKegiatan.includes(:opd).select("DISTINCT ON(program_kegiatans.kode_giat) program_kegiatans.*").where(opds: { kode_unik_opd: @kode_opd })
    if OPD_TABLE.key?(opd.to_sym)
      @programKegiatans = ProgramKegiatan.includes(:opd).select("DISTINCT ON(program_kegiatans.kode_giat) program_kegiatans.*").where(id_sub_unit: KODE_OPD_BAGIAN[opd.to_sym])
    end
    respond_to do |format|
      @render_file = 'program_kegiatans/hasil_filter_kegiatan'
      format.js { render 'program_kegiatans/program_kegiatan_filter' }
    end
  end

  def filter_kak
    opd = Opd.find_by(kode_unik_opd: @kode_opd).nama_opd
    @users = User.includes([:opd]).where(opds: { kode_unik_opd: @kode_opd }).asn_aktif
    if OPD_TABLE.key?(opd.to_sym)
      @users = User.includes([:opd]).where(opds: { kode_unik_opd: KODE_OPD_TABLE[opd.to_sym] }).asn_aktif
      @users = @users.where(nama_bidang: OPD_TABLE[opd.to_sym])
    end
    @filter_file = 'hasil_filter' if params[:filter_file].empty?
    respond_to do |format|
      format.js { render 'kaks/kak_filter' }
    end
  end

  def filter_kak_dashboard
    opd = Opd.find_by(kode_unik_opd: @kode_opd)
    @program_kegiatans = ProgramKegiatan.joins(:opd).where(opds: { kode_opd: opd.kode_opd }).with_sasarans
    if OPD_TABLE.key?(opd.nama_opd.to_sym)
      @program_kegiatans = ProgramKegiatan.joins(:opd).where(opds: { kode_opd: KODE_OPD_TABLE[opd.nama_opd.to_sym] }).with_sasarans
      @program_kegiatans = @program_kegiatans.where(nama_bidang: OPD_TABLE[opd.nama_opd.to_sym]) # idk about bidang thing
    end
    @filter_file = 'hasil_filter_dashboard'
    respond_to do |format|
      format.js { render 'kaks/kak_filter_dashboard' }
    end
  end

  def filter_rab
    opd = Opd.find_by(kode_unik_opd: @kode_opd).nama_opd
    @users = User.includes([:opd]).where(opds: { kode_unik_opd: @kode_opd }).asn_aktif
    if OPD_TABLE.key?(opd.to_sym)
      @users = User.includes([:opd]).where(opds: { kode_unik_opd: KODE_OPD_TABLE[opd.to_sym] }).asn_aktif
      @users = @users.where(nama_bidang: OPD_TABLE[opd.to_sym])
    end
    @filter_file = params[:filter_file].empty? ? 'hasil_filter_rab' : params[:filter_file]
    respond_to do |format|
      format.js { render 'program_kegiatans/rab_filter' }
    end
  end

  def filter_rasionalisasi
    opd = Opd.find_by(kode_unik_opd: @kode_opd).nama_opd
    @program_kegiatans = ProgramKegiatan.includes(%i[opd])
                                        .joins(:sasarans)
                                        .where(opds: { kode_unik_opd: @kode_opd })
    if OPD_TABLE.key?(opd.to_sym)
      @program_kegiatans = ProgramKegiatan.includes(%i[opd])
                                          .joins(:sasarans)
                                          .where(id_sub_unit: KODE_OPD_BAGIAN[opd.to_sym])
    end
    respond_to do |format|
      @render_file = 'rasionalisasi/hasil_filter_rasionalisasi'
      format.js { render 'rasionalisasi/rasionalisasi_filter' }
    end
  end

  def filter_gender
    opd = Opd.find_by(kode_unik_opd: @kode_opd).nama_opd
    @program_kegiatans = ProgramKegiatan.includes(%i[opd sasarans])
                                        .joins(:sasarans)
                                        .where(opds: { kode_unik_opd: @kode_opd })
    if OPD_TABLE.key?(opd.to_sym)
      @program_kegiatans = ProgramKegiatan.includes(%i[opd])
                                          .joins(:sasarans)
                                          .where(id_sub_unit: KODE_OPD_BAGIAN[opd.to_sym])
    end
    respond_to do |format|
      @render_file = 'genders/hasil_filter_gender'
      format.js { render 'genders/gender_filter' }
    end
  end

  def filter_opd
    @opd = Opd.find_by(kode_unik_opd: @kode_opd)
    @filter_file = params[:filter_file].empty? ? 'hasil_filter_opd' : params[:filter_file]
    respond_to do |format|
      format.js { render 'opds/opd_filter' }
    end
  end

  def filter_usulan
    @type = params[:jenis].capitalize
    @type_alsi = @type.capitalize
    if @type == 'Inisiatif'
      @type = 'Inovasi'
      @type_alsi = 'Inisiatif Walikota'
    end
    if @kode_opd == 'all'
      @program_kegiatans = ProgramKegiatan.includes(%i[opd usulans])
                                          .where(usulans: { usulanable_type: @type })
                                          .select { |p| p.sasarans.exists? }
      @nama_opd = 'Semua OPD'
    else
      @program_kegiatans = ProgramKegiatan.includes(%i[opd usulans]).where(opds: { kode_unik_opd: @kode_opd })
                                          .where(usulans: { usulanable_type: @type })
                                          .select { |p| p.sasarans.exists? }
      @nama_opd = nama_opd
    end
    respond_to do |format|
      format.js { render 'usulans/usulan_filter' }
    end
  end

  def filter_user_sasarans
    opd = Opd.find_by(kode_unik_opd: @kode_opd).nama_opd
    @users = User.includes([:opd]).where(opds: { kode_unik_opd: @kode_opd }).asn_aktif
    if OPD_TABLE.key?(opd.to_sym)
      @users = User.includes([:opd]).where(opds: { kode_unik_opd: KODE_OPD_TABLE[opd.to_sym] }).asn_aktif
      @users = @users.where(nama_bidang: OPD_TABLE[opd.to_sym])
    end
    nama_opd
    @filter_file = params[:filter_file].empty? ? 'hasil_filter' : params[:filter_file]
    respond_to do |format|
      format.js { render 'sasarans/user_sasarans' }
    end
  end

  def filter_tematiks
    @kode_tematik = params[:kode_tematik]
    @tahun = params[:tahun]
    @nama_tematik = SubkegiatanTematik.find_by(kode_tematik: @kode_tematik).nama_tematik
    @tematiks = Sasaran.sasaran_tematik(@kode_tematik)
    respond_to do |format|
      format.js { render 'subkegiatan_tematiks/tematik_filter' }
    end
  end

  def filter_struktur
    opd = Opd.find_by(kode_unik_opd: @kode_opd).nama_opd
    @strukturs = Opd.find_by(kode_unik_opd: @kode_opd).kepala
    if OPD_TABLE.key?(opd.to_sym)
      @strukturs = Opd.find_by(kode_unik_opd: KODE_OPD_TABLE[opd.to_sym]).kepala
    end
    # @filter_file = params[:filter_file]
    @filter_file = 'hasil_filter_struktur'
    respond_to do |format|
      format.js { render "users/strukturs" }
    end
  end

  def filter_rekap_jumlah
    if @kode_opd == 'all'
      @rekaps = Rekap.new(kode_unik_opd: @kode_opd).all_rekap
      @nama_opd = 'Kota Madiun'
    else
      @rekaps = Rekap.new(kode_unik_opd: @kode_opd).jumlah_rekap
      @nama_opd = nama_opd
    end
    @filter_file = params[:filter_file]
    respond_to do |format|
      format.js { render 'rekaps/rekap_jumlah' }
    end
  end

  private

  def filter_params
    @kode_opd = params[:kode_opd]
    @tahun = params[:tahun]
    @bulan = params[:bulan]
  end

  def nama_opd
    @nama_opd ||= Opd.find_by(kode_unik_opd: @kode_opd).nama_opd || '-'
  end

  def bidang_checker(models)
    opd = Opd.find_by(kode_unik_opd: @kode_opd).nama_opd
    @results = models.includes([:opd]).where(opds: { kode_unik_opd: @kode_opd })
    if OPD_TABLE.key?(opd.to_sym)
      @results = models.includes([:opd]).where(opds: { kode_unik_opd: KODE_OPD_TABLE[opd.to_sym] })
      @results = @results.where(nama_bidang: OPD_TABLE[opd.to_sym])
    end
  end
end
