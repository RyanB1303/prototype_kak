# == Schema Information
#
# Table name: search_all_anggarans
#
#  harga_satuan    :bigint
#  kode_barang     :string
#  satuan          :string
#  searchable_type :text
#  spesifikasi     :string
#  tahun           :string
#  uraian_barang   :string
#  opd_id          :bigint
#  searchable_id   :bigint
#
FactoryBot.define do
  factory :search_all_anggaran, class: 'Search::AllAnggaran' do
  end
end
