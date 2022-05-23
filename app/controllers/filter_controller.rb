class FilterController < ApplicationController
  before_action :filter_params

  OPD_TABLE = {
    'Dinas Kesehatan, Pengendalian Penduduk dan Keluarga Berencana': 'Dinas Kesehatan',
    'Rumah Sakit Umum Daerah Kota Madiun': 'Rumah Sakit Umum Daerah',
    'Sekretariat Daerah': nil,
    'Bagian Umum': 'Bagian Umum',
    'Bagian Pengadaan Barang / Jasa dan Administrasi Pembangunan': 'Bagian Pengadaan Barang/Jasa dan Administrasi Pembangunan',
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
    'Bagian Pengadaan Barang / Jasa dan Administrasi Pembangunan': '4.01.0.00.0.00.01.00',
    'Bagian Organisasi': '4.01.0.00.0.00.01.00',
    'Bagian Hukum': '4.01.0.00.0.00.01.00',
    'Bagian Perekonomian dan Kesejahteraan Rakyat': '4.01.0.00.0.00.01.00',
    'Bagian Pemerintahan': '4.01.0.00.0.00.01.00'
  }.freeze

  def filter_sasaran
    opd = Opd.find_by(kode_unik_opd: @kode_opd).nama_opd
    @sasarans = Sasaran.includes([user: :opd]).where(opds: { kode_unik_opd: @kode_opd })
    if OPD_TABLE.key?(opd.to_sym)
      @sasarans = Sasaran.includes([user: :opd]).where(opds: { kode_unik_opd: KODE_OPD_TABLE[opd.to_sym] })
      @sasarans = @sasarans.where(user: { nama_bidang: OPD_TABLE[opd.to_sym] })
    end
    respond_to do |format|
      format.js { render 'sasarans/sasaran_filter' }
    end
  end

  def filter_user
    opd = Opd.find_by(kode_unik_opd: @kode_opd).nama_opd
    @users = User.includes([:opd]).where(opds: { kode_unik_opd: @kode_opd })
    if OPD_TABLE.key?(opd.to_sym)
      @users = User.includes([:opd]).where(opds: { kode_unik_opd: KODE_OPD_TABLE[opd.to_sym] })
      @users = @users.where(nama_bidang: OPD_TABLE[opd.to_sym])
    end
    @filter_file = 'hasil_filter' if params[:filter_file].empty?
    respond_to do |format|
      format.js { render 'users/user_filter' }
    end
  end

  def filter_program
    @programKegiatans = ProgramKegiatan.includes(%i[opd subkegiatan_tematik]).where(opds: { kode_unik_opd: @kode_opd })
    respond_to do |format|
      @render_file = 'program_kegiatans/hasil_filter'
      format.js { render 'program_kegiatans/program_kegiatan_filter' }
    end
  end

  def filter_program_saja
    @programKegiatans = ProgramKegiatan.includes(:opd).select("DISTINCT ON(program_kegiatans.id_program_sipd) program_kegiatans.*").where(opds: { kode_unik_opd: @kode_opd })
    respond_to do |format|
      @render_file = 'program_kegiatans/hasil_filter_program'
      format.js { render 'program_kegiatans/program_kegiatan_filter' }
    end
  end

  def filter_kegiatan
    @programKegiatans = ProgramKegiatan.includes(:opd).select("DISTINCT ON(program_kegiatans.kode_giat) program_kegiatans.*").where(opds: { kode_unik_opd: @kode_opd })
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

  def filter_rab
    opd = Opd.find_by(kode_unik_opd: @kode_opd).nama_opd
    @users = User.includes([:opd]).where(opds: { kode_unik_opd: @kode_opd }).asn_aktif
    if OPD_TABLE.key?(opd.to_sym)
      @users = User.includes([:opd]).where(opds: { kode_unik_opd: KODE_OPD_TABLE[opd.to_sym] }).asn_aktif
      @users = @users.where(nama_bidang: OPD_TABLE[opd.to_sym])
    end
    @filter_file = 'hasil_filter_rab' if params[:filter_file].empty?
    respond_to do |format|
      format.js { render 'program_kegiatans/rab_filter' }
    end
  end

  def filter_rasionalisasi
    @program_kegiatans = ProgramKegiatan.includes(%i[opd subkegiatan_tematik]).where(opds: { kode_unik_opd: @kode_opd })
    respond_to do |format|
      @render_file = 'rasionalisasi/hasil_filter_rasionalisasi'
      format.js { render 'rasionalisasi/rasionalisasi_filter' }
    end
  end

  private

  def filter_params
    @kode_opd = params[:kode_opd]
    @tahun = params[:tahun]
    @bulan = params[:bulan]
  end
end
