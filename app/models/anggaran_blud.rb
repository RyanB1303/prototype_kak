# == Schema Information
#
# Table name: anggaran_bluds
#
#  id                     :bigint           not null, primary key
#  harga_satuan           :bigint
#  kode_barang            :string
#  kode_kelompok_barang   :string
#  satuan                 :string
#  spesifikasi            :string
#  tahun                  :string
#  uraian_barang          :string
#  uraian_kelompok_barang :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  opd_id                 :bigint
#
class AnggaranBlud < ApplicationRecord
  validates :kode_barang, presence: true
  validates :kode_kelompok_barang, presence: true
  validates :uraian_barang, presence: true
  validates :harga_satuan, numericality: true
end
