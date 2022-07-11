# == Schema Information
#
# Table name: subkegiatan_priorities
#
#  id           :bigint           not null, primary key
#  kode_priority :string
#  nama_priority :string
#  tahun        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class SubkegiatanPriority < ApplicationRecord
  # has_many :program_kegiatans
  has_many :priority_sasarans
  has_many :sasarans, through: :priority_sasarans
  validates :kode_priority, presence: true
  validates :nama_priority, presence: true
end
