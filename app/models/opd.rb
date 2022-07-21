# == Schema Information
#
# Table name: opds
#
#  id                 :bigint           not null, primary key
#  bidang_urusan      :string
#  id_daerah          :string
#  id_opd_skp         :integer
#  kode_bidang_urusan :string
#  kode_opd           :string
#  kode_unik_opd      :string
#  kode_urusan        :string
#  nama_kepala        :string
#  nama_opd           :string
#  nip_kepala         :string
#  pangkat_kepala     :string
#  status_kepala      :string
#  tahun              :string
#  urusan             :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  lembaga_id         :integer
#
# Indexes
#
#  index_opds_on_kode_unik_opd  (kode_unik_opd) UNIQUE
#
class Opd < ApplicationRecord
  validates :nama_opd, presence: true
  validates :kode_opd, presence: true
  has_many :users, foreign_key: 'kode_opd', primary_key: 'kode_opd'
  has_many :program_kegiatans, foreign_key: 'kode_opd', primary_key: 'kode_opd'
  belongs_to :lembaga
  has_many :sasaran_opds, foreign_key: 'sasaran_opd', primary_key: 'kode_unik_opd'
  has_one :kepala, -> { where(type: 'Kepala') }, class_name: 'Kepala', foreign_key: :kode_opd, primary_key: :kode_opd
  def text_urusan
    return nil unless urusan

    "#{kode_urusan} #{urusan.capitalize}"
  end

  def text_bidang_urusan
    return nil unless bidang_urusan

    "#{kode_bidang_urusan} #{bidang_urusan.capitalize}"
  end

  def jabatan_kepala
    User.find_by(nik: nip_kepala.delete(" \t\r\n")).jabatan
  rescue NoMethodError
    'Kepala'
  end
end
