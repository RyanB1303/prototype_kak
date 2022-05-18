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
#  penerima_manfaat       :string
#  sasaran_kinerja        :string
#  satuan                 :string
#  status                 :enum             default("draft")
#  sumber_dana            :string
#  tahun                  :string
#  target                 :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  program_kegiatan_id    :bigint
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
  # belongs_to :user
  belongs_to :user, foreign_key: 'nip_asn', primary_key: 'nik'
  belongs_to :program_kegiatan, optional: true
  has_many :tematik_sasarans
  has_many :subkegiatan_tematiks, through: :tematik_sasarans
  # belongs_to :sumber_dana, foreign_key: 'sumber_dana', primary_key: 'kode_sumber_dana', optional: true

  has_many :usulans
  has_many :dasar_hukums, foreign_key: 'sasaran_id', primary_key: 'id_rencana', class_name: 'DasarHukum'
  # has_many :musrenbangs
  # has_many :pokpirs
  # has_many :mandatoris
  # has_many :inovasis
  has_many :indikator_sasarans, foreign_key: 'sasaran_id', primary_key: 'id_rencana', dependent: :destroy
  has_many :tahapans, foreign_key: 'id_rencana', primary_key: 'id_rencana', dependent: :destroy
  has_one :rincian, dependent: :destroy
  has_many :permasalahans, dependent: :destroy
  has_many :latar_belakangs, dependent: :destroy

  accepts_nested_attributes_for :rincian, update_only: true
  accepts_nested_attributes_for :tahapans
  # TODO: ganti kualitas dengan aspek ( multiple choice )
  # validation
  validates :sasaran_kinerja, presence: true
  # validates :indikator_kinerja, presence: true
  # validates :target, presence: true
  # validates :satuan, presence: true

  default_scope { order(created_at: :asc) }
  scope :hangus, -> { left_outer_joins(:usulans).where(usulans: { sasaran_id: nil }).where(program_kegiatan: nil) }
  scope :total_hangus, -> { hangus.count }
  scope :belum_ada_sub, -> { left_outer_joins(:usulans).where.not(usulans: { sasaran_id: nil }).where(program_kegiatan: nil) }
  scope :total_belum_lengkap, -> { belum_ada_sub.count }
  scope :sudah_lengkap, lambda {
                          includes(:usulans).where.not(usulans: { sasaran_id: nil }).where.not(program_kegiatan: nil)
                        }
  scope :total_sudah_lengkap, -> { sudah_lengkap.count }
  scope :digunakan, -> { where(status: 'disetujui') }
  scope :total_digunakan, -> { where(status: 'disetujui').count }
  scope :dilaporan, -> { where(status: ['pengajuan', 'disetujui', 'ditolak']) }

  SUMBERS = { dana_transfer: 'Dana Transfer', dak: 'DAK', dbhcht: 'DBHCHT', bk_provinsi: 'BK Provinsi',
              blud: 'BLUD' }.freeze

  enum status: { draft: 'draft', pengajuan: 'pengajuan', disetujui: 'disetujui', ditolak: 'ditolak' }

  # DANGER, maybe broke something, uncomment this
  # def respond_to_missing?(_method, *_args)
  #   0
  # end

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
    tahapans.map { |t| t.anggarans.compact.sum(&:jumlah) }.inject(:+)
  rescue TypeError
    '-'
  end

  def total_anggaran_dengan_komentar
    tahapans.map { |t| t.anggarans.where.missing(:comments).compact.sum(&:jumlah) }.inject(:+)
  rescue TypeError
    '-'
  end

  def jumlah_target
    tahapans.sum(:jumlah_target).nonzero? || '-'
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
    !(hangus? || belum_ada_sub?)
  end

  def status_sasaran
    if hangus? && status != 'disetujui'
      'hangus'
    elsif belum_ada_sub?
      'blm_lengkap'
    else
      'digunakan'
    end
  end

  def add_tematik(sasaran:, tematik:)
    tematik_exists = TematikSasaran.where(sasaran_id: sasaran, subkegiatan_tematik_id: tematik)
    if tematik_exists.exists?
      tematik_exists.update(sasaran_id: sasaran, subkegiatan_tematik_id: tematik)
    else
      TematikSasaran.create(sasaran_id: sasaran, subkegiatan_tematik_id: tematik)
    end
  end
end
