# == Schema Information
#
# Table name: sasarans
#
#  id                     :bigint           not null, primary key
#  anggaran               :integer
#  id_rencana             :string
#  indikator_kinerja      :string
#  kualitas               :integer
#  nip_asn                :string
#  nip_asn_sebelumnya     :string
#  penerima_manfaat       :string
#  sasaran_atasan         :string
#  sasaran_kinerja        :string
#  sasaran_kota           :string
#  sasaran_milik          :string
#  sasaran_opd            :string
#  satuan                 :string
#  status                 :enum             default("draft")
#  sumber_dana            :string
#  tahun                  :string
#  target                 :integer
#  type                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  program_kegiatan_id    :bigint
#  sasaran_atasan_id      :string
#  strategi_id            :string
#  subkegiatan_tematik_id :bigint
#
# Indexes
#
#  index_sasarans_on_id_rencana  (id_rencana) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (nip_asn => users.nik)
#  fk_rails_...  (subkegiatan_tematik_id => subkegiatan_tematiks.id)
#
class Sasaran < ApplicationRecord
  default_scope { order(:id) }
  # belongs_to :user
  belongs_to :user, foreign_key: 'nip_asn', primary_key: 'nik'
  has_one :opd, through: :user
  belongs_to :program_kegiatan, optional: true
  has_many :tematik_sasarans, dependent: :destroy
  has_many :subkegiatan_tematiks, through: :tematik_sasarans
  # belongs_to :sumber_dana, foreign_key: 'sumber_dana', primary_key: 'kode_sumber_dana', optional: true

  has_many :usulans, dependent: :destroy
  has_many :dasar_hukums, foreign_key: 'sasaran_id', primary_key: 'id_rencana', class_name: 'DasarHukum',
                          dependent: :destroy
  has_many :musrenbangs, dependent: :nullify
  has_many :pokpirs, dependent: :nullify
  has_many :mandatoris, dependent: :nullify
  has_many :inovasis, dependent: :nullify
  has_many :indikator_sasarans, foreign_key: 'sasaran_id', primary_key: 'id_rencana', dependent: :destroy
  has_many :tahapans, foreign_key: 'id_rencana', primary_key: 'id_rencana', dependent: :destroy, inverse_of: :sasaran
  has_many :anggarans, through: :tahapans
  has_one :rincian, dependent: :destroy
  has_many :permasalahans, dependent: :destroy
  has_many :latar_belakangs, dependent: :destroy
  has_many :genders
  belongs_to :strategi, dependent: :destroy, optional: true
  # has_one :strategi
  # has_many :manual_iks, through: :indikator_sasarans

  accepts_nested_attributes_for :rincian, update_only: true
  accepts_nested_attributes_for :tahapans
  accepts_nested_attributes_for :permasalahans
  accepts_nested_attributes_for :indikator_sasarans, reject_if: :all_blank, allow_destroy: true
  # TODO: ganti kualitas dengan aspek ( multiple choice )
  # validation
  validates :sasaran_kinerja, presence: true
  # validates :indikator_kinerja, presence: true
  # validates :target, presence: true
  # validates :satuan, presence: true

  # default_scope { order(created_at: :asc) }
  scope :hangus, -> { left_outer_joins(:usulans).where(usulans: { sasaran_id: nil }).where(program_kegiatan: nil) }
  scope :total_hangus, -> { hangus.count }
  scope :belum_ada_sub, lambda {
                          left_outer_joins(:usulans)
                            .where.not(usulans: { sasaran_id: nil })
                            .where(program_kegiatan: nil)
                        }
  scope :total_belum_lengkap, -> { belum_ada_sub.count }
  scope :sudah_lengkap, lambda {
                          includes(:usulans, :program_kegiatan).where.not(usulans: { sasaran_id: nil }).where.not(program_kegiatan: nil)
                        }
  scope :total_sudah_lengkap, -> { sudah_lengkap.count }
  scope :digunakan, -> { where(status: 'disetujui') }
  scope :total_digunakan, -> { where(status: 'disetujui').count }
  scope :dilaporan, -> { where(status: %w[pengajuan disetujui ditolak]) }
  scope :sasaran_tematik, lambda { |tematik|
                            includes(:subkegiatan_tematiks).where(subkegiatan_tematiks: { kode_tematik: tematik })
                          }
  scope :kurang_lengkap, -> { select { |s| s.usulans.exists? && s.belum_ada_sub? }.size }
  scope :hijau, -> { select(&:lengkap?).size }
  scope :biru, -> { select(&:selesai?).reject(&:lengkap?).size }
  scope :dengan_sub_kegiatan, -> { joins(:program_kegiatan) }
  scope :dengan_tahapan, -> { joins(:tahapans) }
  scope :dengan_rincian, -> { joins(:rincian).includes(:tahapans).where.not(tahapans: { id_rencana: nil }) }
  scope :belum_ada_genders, -> { where.missing(:genders) }
  scope :dengan_strategi, -> { select { |s| s.strategi.present? } }
  scope :dengan_manual_ik, -> { select { |s| s.indikator_sasarans.any?(&:manual_ik) } }

  SUMBERS = { dana_transfer: 'Dana Transfer', dak: 'DAK', dbhcht: 'DBHCHT', bk_provinsi: 'BK Provinsi',
              blud: 'BLUD' }.freeze

  enum status: { draft: 'draft', pengajuan: 'pengajuan', disetujui: 'disetujui', ditolak: 'ditolak' }

  # DANGER, maybe broke something, uncomment this
  # def respond_to_missing?(_method, *_args)
  #   0
  # end
  amoeba do
    set tahun: '2022_p'
    append id_rencana: '_2022_p'
    include_association %i[rincian tematik_sasarans usulans permasalahans]
    # exclude_association %i[indikator_sasarans latar_belakangs dasar_hukums]
  end

  def aksi_bulan_kosong?
    tahapans.map { |t| t.aksis.map(&:id_aksi_bulan) }.flatten.include?(nil)
  end

  def gambaran_umum_indikator_kosong?
    latar_belakangs.map(&:id_indikator_sasaran).include?(nil)
  end

  def tahun_clone_preparer
    tahun.to_s.split('_').first
  end

  def program_nil?
    program_kegiatan.nil?
  end

  # method yang ada map nya memang sengaja begitu, karena dibuat collection dan di loop untuk footer bulan
  def target_bulan
    tahapans.map { |t| t.aksis.group(:bulan).sum(:target) }
  end

  def realisasi_bulan
    tahapans.map { |t| t.aksis.group(:bulan).sum(:realisasi) }
  end

  def total_target_aksi_bulan
    tahapans.map { |t| t.aksis.group(:bulan).sum(:target) }.inject do |bln, val|
      bln.merge(val) do |_k, old_v, new_v|
        old_v + new_v
      end
    end
  end

  def total_realisasi_aksi_bulan
    tahapans.map { |t| t.aksis.group(:bulan).sum(:realisasi) }.inject do |bln, val|
      bln.merge(val) do |_k, old_v, new_v|
        old_v + new_v
      end
    end
  end

  def waktu_total
    tahapans.map { |t| t.aksis.group(:bulan).where('target > 0').count(:target) }.inject(:merge).count
  rescue NoMethodError
    '-'
  end

  def progress_total
    jumlah_target = tahapans.sum :jumlah_target
    jumlah_realisasi = tahapans.sum :jumlah_realisasi
    begin
      ((jumlah_realisasi / jumlah_target.to_f) * 100)
    rescue StandardError
      0
    end
  end

  def total_anggaran
    tahapans.includes([:anggarans]).map { |t| t.anggarans.compact.sum(&:jumlah) }.inject(:+)
  rescue TypeError
    '-'
  end

  def total_anggaran_dengan_komentar
    tahapans.map { |t| t.anggarans.where.missing(:comments).compact.sum(&:jumlah) }.inject(:+)
  rescue TypeError
    '-'
  end

  def total_anggaran_penetapan
    tahapans.map(&:anggaran_tahapan_penetapan).inject(:+)
  rescue TypeError
    '-'
  end

  def anggaran_sub
    program_kegiatan&.pagu_tanpa_lengkap(tahun) || 0
  end

  def jumlah_target
    tahapans.sum(:jumlah_target).nonzero? || '-'
  end

  def target_sesuai?
    jumlah_target.to_i == 100
  rescue NoMethodError
    '-'
  end

  def my_usulan
    usulans.map(&:usulanable)
  end

  def sync_total_renaksi
    tahapans.each(&:sync_total_renaksi)
  end

  def hangus?
    usulans.empty?
  end

  def belum_ada_sub?
    program_kegiatan.nil?
  end

  def selesai?
    # !(hangus? || belum_ada_sub?)
    usulans.exists? && program_kegiatan.present?
  end

  def lengkap?
    selesai? && rincian? && permasalahan? && dasar_hukum? && gambaran_umum? && tematik?
  end

  def rincian?
    rincian.present? && penerima_manfaat.present?
  end

  def permasalahan?
    permasalahans.exists?
  end

  def dasar_hukum?
    dasar_hukums.exists?
  end

  def gambaran_umum?
    latar_belakangs.exists?
  end

  def tematik?
    subkegiatan_tematiks.exists?
  end

  def biru?
    selesai? && subkegiatan_tematiks.empty?
  end

  def biru_helper
    petunjuk_status.except(:usulan_dan_sub).values.any?(false)
  end

  # TODO: try this method to simplify in user
  def status_sasaran
    if siap_ditarik?
      'siap_ditarik'
    elsif hangus?
      # 'hangus' # merah
      'belum_selesai'
    elsif belum_ada_sub?
      'blm_lengkap' # kuning
    elsif biru_helper
      'krg_lengkap' # biru
    elsif lengkap?
      'digunakan' # hijau
    end
  end

  def petunjuk_status
    usulan_dan_sub = selesai?
    rincian_sasaran = rincian.present? && penerima_manfaat.present?
    permasalahan_rencan = permasalahans.any?
    dasar_hukum = dasar_hukums.any?
    gambaran_umum = latar_belakangs.any?
    tematik_saaran = subkegiatan_tematiks.any?
    manual_ik = manual_ik?
    tahapan = tahapan?
    {
      usulan_dan_sub: usulan_dan_sub,
      rincian_sasaran: rincian_sasaran,
      permasalahan: permasalahan_rencan,
      dasar_hukum: dasar_hukum,
      gambaran_umum: gambaran_umum,
      tematik: tematik_saaran,
      manual_ik: manual_ik,
      tahapan: tahapan
    }
  end

  def petunjuk_tarik
    manual_ik = manual_ik?
    tahapan = tahapan?
    {
      manual_ik: manual_ik,
      tahapan: tahapan
    }
  end

  def status_badge(petunjuk)
    petunjuk.reject { |_key, val| val }
  end

  def add_tematik(sasaran:, tematik:)
    tematik_exists = TematikSasaran.where(sasaran_id: sasaran, subkegiatan_tematik_id: tematik)
    if tematik_exists.exists?
      tematik_exists.update(sasaran_id: sasaran, subkegiatan_tematik_id: tematik)
    else
      TematikSasaran.create(sasaran_id: sasaran, subkegiatan_tematik_id: tematik)
    end
  end

  def rekin_atasan
    return nil if sasaran_atasan_id.nil?

    Sasaran.find_by(id_rencana: sasaran_atasan_id)
  end

  def indikator_rekin_atasan
    return nil if sasaran_atasan_id.nil?

    rekin_atasan.indikator_sasarans
  end

  def program_kabid
    sasaran_kasi.map { |s| s.program_kegiatan&.nama_program || '-' }.uniq
  end

  def sasaran_kasi
    Sasaran.where(sasaran_atasan_id: id_rencana).dengan_sub_kegiatan
  end

  def permasalahan_sasaran
    permasalahans.map(&:permasalahan).join('.')
  end

  def in_gender?
    genders.any?
  end

  def gambaran_umum_sasaran
    latar_belakangs.map(&:gambaran_umum).join('.')
  end

  def strategi?
    strategi.present?
  end

  def tahapan?
    tahapans.exists?
  end

  def manual_ik?
    indikator_sasarans.any?(&:manual_ik)
  end

  def siap_ditarik?
    strategi? && tahapan? && manual_ik?
  end

  def sasaran_kota
    pohon = strategi.pohon
    # return unless pohon.pohonable_type == 'StrategiKotum'

    pohon_kota = pohon.pohonable
    {
      strategi_kota: pohon_kota.strategi,
      sasaran_kota_id: pohon_kota&.sasaran_kotum_id,
      sasaran_kota: pohon_kota&.sasaran_kotum_sasaran
    }
  end

  def sasaran_atasan_pohon
    strategi_atasan_now = strategi&.strategi_atasan
    sasaran_atasan_now = strategi_atasan_now&.sasaran
    {
      strategi_atasan: strategi_atasan_now&.strategi,
      sasaran_atasan_id: sasaran_atasan_now&.id_rencana,
      sasaran_atasan: sasaran_atasan_now&.sasaran_kinerja,
      nama_atasan: sasaran_atasan_now&.user&.nama_nip
    }
  end

  def subkegiatan
    program_kegiatan.present? ? program_kegiatan.nama_subkegiatan : 'belum ada subkegiatan'
  end

  def kode_subkegiatan_sasaran
    program_kegiatan.kode_sub_giat
  end

  # @doc get tahapan rencana aksi sasaran with correct sort
  def tahapan_renaksi
    tahapans.includes([:anggarans]).sort_by do |thp|
      thp.urutan.to_i
    end
  end
end
