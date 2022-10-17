json.results @programKegiatans do |program|
  json.id program.id
  json.text "#{program.nama_opd_pemilik} | #{program.nama_subkegiatan} | #{program.tahun} | jumlah_sasaran: #{program.sasarans.dengan_rincian.size}"
  # json.sasarans program.sasarans.dengan_rincian, partial: 'sasarans/data_detail', as: :sasaran
end
