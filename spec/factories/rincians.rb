# == Schema Information
#
# Table name: rincians
#
#  id                  :bigint           not null, primary key
#  dampak              :string
#  data_terpilah       :string
#  lokasi_pelaksanaan  :string
#  penyebab_external   :string
#  penyebab_internal   :string
#  permasalahan_gender :string
#  permasalahan_umum   :string
#  resiko              :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  kemungkinan_id      :integer
#  sasaran_id          :bigint           not null
#  skala_id            :bigint
#
# Indexes
#
#  index_rincians_on_sasaran_id  (sasaran_id)
#  index_rincians_on_skala_id    (skala_id)
#
# Foreign Keys
#
#  fk_rails_...  (sasaran_id => sasarans.id)
#
FactoryBot.define do
  factory :rincian do
    data_terpilah { 'Data Terpilah' }
    lokasi_pelaksanaan { 'Lokasi Pelaksanaan' }

    association :sasaran
  end
end
