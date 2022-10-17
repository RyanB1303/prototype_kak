json.extract! sasaran, :sasaran_kinerja, :penerima_manfaat
json.permasalahan sasaran.permasalahan_sasaran
json.extract! sasaran.rincian, :data_terpilah, :penyebab_external, :penyebab_internal
json.indikators sasaran.indikator_sasarans do |indikator|
  json.indikator indikator.indikator_kinerja
  json.target indikator.target
  json.satuan indikator.satuan
end
