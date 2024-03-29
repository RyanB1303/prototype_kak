if indikators.any? { |ind| ind.tahun == tahun.to_s }
  indikators.each do |indikator|
    next unless indikator.tahun == tahun.to_s

    json.tahun tahun
    json.indikator indikator.indikator
    json.target indikator.target
    json.satuan indikator.satuan
    json.realisasi indikator.realisasi
    json.satuan indikator.satuan

    if indikator.sub_jenis == 'Subkegiatan'
      json.pagu indikator.pagu
      json.pagu_realisasi indikator.realisasi_pagu
    else
      json.pagu indikator.sum_pagu_renstra(sub_jenis: 'Subkegiatan')
      json.pagu_realisasi indikator.sum_realisasi_pagu_renstra(sub_jenis: 'Subkegiatan')
    end
  end
else
  json.tahun tahun
  json.indikator ""
  json.target 0
  json.satuan ""
  json.realisasi 0
  json.satuan ""
  json.pagu 0
  json.pagu_realisasi 0
end
