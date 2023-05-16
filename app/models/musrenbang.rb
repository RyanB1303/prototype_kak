# == Schema Information
#
# Table name: musrenbangs
#
#  id         :bigint           not null, primary key
#  alamat     :text
#  id_kamus   :bigint
#  id_unik    :bigint
#  is_active  :boolean          default(FALSE)
#  nip_asn    :string
#  opd        :string
#  status     :enum             default("draft")
#  tahun      :string
#  uraian     :string
#  usulan     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sasaran_id :bigint
#
# Indexes
#
#  index_musrenbangs_on_id_unik     (id_unik) UNIQUE
#  index_musrenbangs_on_sasaran_id  (sasaran_id)
#  index_musrenbangs_on_status      (status)
#
class Musrenbang < ApplicationRecord
  validates :usulan, presence: true
  # validates :tahun, presence: true, numericality: { only_integer: true }
  # has_rich_text :usulan

  enum status: { draft: 'draft', pengajuan: 'pengajuan', disetujui: 'disetujui', aktif: 'aktif',
                 ditolak: 'ditolak', menunggu_persetujuan: 'menunggu_persetujuan' }

  belongs_to :sasaran, optional: true
  belongs_to :opd_dituju, class_name: 'Opd', foreign_key: 'opd', primary_key: 'id_opd_skp', optional: true
  has_many :usulans, as: :usulanable, dependent: :destroy
  has_many :kamus_usulans, foreign_key: 'id_kamus', primary_key: 'id_kamus'

  default_scope { order(updated_at: :desc) }
  scope :diambil_asn, -> { where.not(nip_asn: nil) }
  scope :belum_diajukan, -> { where(nip_asn: nil) }
  scope :belum_diambil_asn, -> { where(sasaran_id: nil) }
  scope :menunggu_persetujuan, -> { where(status: 'menunggu_persetujuan') }
  scope :with_kamus, -> { joins(:kamus_usulans) }

  def asn_pengambil
    User.find_by(nik: nip_asn).nama
  rescue NoMethodError
    '-'
  end

  def opd_asn
    User.find_by(nik: nip_asn).opd.nama_opd
  rescue NoMethodError
    '-'
  end

  def opd_pemilik
    User.find_by(nik: nip_asn).opd.kode_opd
  rescue NoMethodError
    '-'
  end

  def sasaran_aktif?
    sasaran_id.present?
  end

  def asn_aktif?
    nip_asn.present?
  end
end
