# == Schema Information
#
# Table name: program_kegiatans
#
#  id                        :bigint           not null, primary key
#  id_giat                   :string
#  id_program_sipd           :string
#  id_sub_giat               :string
#  id_sub_unit               :string
#  id_unit                   :string
#  identifier_belanja        :string
#  indikator_kinerja         :string
#  indikator_program         :string
#  indikator_subkegiatan     :string
#  kode_bidang_urusan        :string
#  kode_giat                 :string
#  kode_opd                  :string
#  kode_program              :string
#  kode_skpd                 :string
#  kode_sub_giat             :string
#  kode_sub_skpd             :string
#  kode_urusan               :string
#  nama_bidang_urusan        :string
#  nama_kegiatan             :string
#  nama_program              :string
#  nama_subkegiatan          :string
#  nama_urusan               :string
#  pagu                      :string
#  satuan                    :string
#  satuan_target_program     :string
#  satuan_target_subkegiatan :string
#  tahun                     :string
#  target                    :string
#  target_program            :string
#  target_subkegiatan        :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  subkegiatan_tematik_id    :bigint
#
# Indexes
#
#  index_program_kegiatans_on_identifier_belanja      (identifier_belanja) UNIQUE
#  index_program_kegiatans_on_subkegiatan_tematik_id  (subkegiatan_tematik_id)
#
# Foreign Keys
#
#  fk_rails_...  (subkegiatan_tematik_id => subkegiatan_tematiks.id)
#

class ProgramKegiatan < ApplicationRecord
  validates :nama_program, presence: true
  # validates :indikator_kinerja, presence: true
  # validates :target, presence: true
  # validates :satuan, presence: true
  belongs_to :opd, foreign_key: 'kode_opd', primary_key: 'kode_opd'
  # belongs_to :subkegiatan_tematik, optional: true
  has_many :kaks
  has_many :sasarans, dependent: :nullify
  has_many :usulans, through: :sasarans
  has_many :subkegiatan_tematiks, through: :sasarans
  has_many :rincians, through: :sasarans
  has_many :permasalahans, through: :sasarans

  scope :with_sasarans, -> { where(id: Sasaran.pluck(:program_kegiatan_id)) }

  # default_scope { order(created_at: :desc) }

  def my_pagu
    sasarans.sudah_lengkap.map(&:total_anggaran).compact.sum
  end

  def my_waktu
    sasarans.map(&:waktu_total).compact.sum
  end

  def nama_opd_pemilik
    id_sub_unit.nil? ? '-' : Opd.find_by(id_opd_skp: id_sub_unit).nama_opd
  end

  def count_indikator_sasarans
    sasarans.map { |s| s.indikator_sasarans.count }.inject(:+)
  end

  def all_anggaran
    sasarans.map(&:total_anggaran).compact.sum
  end

  def jumlah_sasaran
    sasarans.size
  end
end
