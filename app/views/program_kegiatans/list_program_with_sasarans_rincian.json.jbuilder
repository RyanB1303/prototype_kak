json.results @program_kegiatans do |program|
  json.id program.id
  json.text "#{program.nama_opd_pemilik} | #{program.nama_subkegiatan} | tahun: #{program.tahun} | jumlah_sasaran: #{program.sasarans.belum_ada_genders.dengan_rincian.size}"
  # json.sasarans program.sasarans, partial: 'sasarans/data_detail', as: :sasaran
end
