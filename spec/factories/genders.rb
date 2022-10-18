# == Schema Information
#
# Table name: genders
#
#  id                  :bigint           not null, primary key
#  akses               :string
#  data_terpilah       :string
#  indikator           :string
#  kontrol             :string
#  manfaat             :string
#  partisipasi         :string
#  penerima_manfaat    :string
#  penyebab_external   :string
#  penyebab_internal   :string
#  reformulasi_tujuan  :string
#  sasaran_subkegiatan :string
#  satuan              :string
#  tahun               :string
#  target              :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  program_kegiatan_id :bigint
#  sasaran_id          :bigint
#
# Indexes
#
#  index_genders_on_program_kegiatan_id  (program_kegiatan_id)
#  index_genders_on_sasaran_id           (sasaran_id)
#
FactoryBot.define do
  factory :gender do
    akses { "Contoh Akses" }
    kontrol { "Contoh Kontrol" }
    manfaat { "Contoh Manfaat" }
    partisipasi { "Contoh Partisipasi" }
    indikator { "Contoh Indikator A" }
    target { "Contoh Target A" }
    satuan { "%" }
    reformulasi_tujuan { "Contoh Reformulasi Tujuan" }
    penerima_manfaat { "Contoh Penerima Manfaat" }
    sasaran_subkegiatan { "Contoh Sasaran Subkegiatan" }
    penyebab_internal { ["Penyebab Internal 1", "Penyebab Internal 2"] }
    penyebab_external { ["Penyebab External 1", "Penyebab External 2"] }
    data_terpilah { ["Data Terpilah 1", "Data Terpilah 2"] }
    association :program_kegiatan
  end
end
