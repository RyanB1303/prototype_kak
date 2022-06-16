prawn_document(filename: @filename, page_layout: :landscape, disposition: "attachment") do |pdf|
  pdf.font_families.clear
  pdf.font_families.update("TiroKannada" => {
                                      normal: "vendor/assets/fonts/TiroKannada-Regular.ttf",
                                      italic: "vendor/assets/fonts/TiroKannada-Italic.ttf",
                                      bold: "vendor/assets/fonts/NotoSerif-Bold.ttf"
                                      })
  pdf.font "TiroKannada"
  size_cell = 8
  height_nested = 30
  width_nested = 150
  rowspan = 0
  pdf.text "DAFTAR SUB KEGIATAN #{@jenis_asli.upcase}", align: :center
  pdf.move_down 3
  pdf.text "KOTA MADIUN TAHUN #{@tahun}", align: :center
  pdf.move_down 3
  pdf.text "#{@nama_opd.upcase}", align: :center

  pdf.move_down 20
  header_tabel_usulan = [
    [{ content: 'No', align: :center }, { content: @jenis_asli, align: :center }, { content: 'Sub Kegiatan', align: :center },
     { content: 'Program', align: :center }, { content: 'Pagu Anggaran', align: :center }, { content: 'OPD', align: :center },
     { content: 'Uraian', align: :center }, { content: 'Keterangan', align: :center }]
  ]
  pdf.font "TiroKannada"

  @program_kegiatans.each.with_index(1) do |pk, i|
    usulan_arr = []
    lokasi_arr = []
    keterangan_arr = []
    pk.usulans.where(usulanable_type: @jenis).each do |us|
      keterangan = us.usulanable.try(:alamat) || us.usulanable.try(:peraturan_terkait) || us.usulanable.try(:manfaat)
      usulan_arr << [us.usulanable&.usulan]
      lokasi_arr << [us.usulanable&.uraian]
      keterangan_arr << [keterangan]
    end
    usulan_table = pdf.make_table(usulan_arr, cell_style: { size: size_cell, height: height_nested, valign: :center }, width: width_nested)
    lokasi_table = pdf.make_table(lokasi_arr, cell_style: { size: size_cell, height: height_nested, valign: :center }, width: width_nested)
    keterangan_table = pdf.make_table(keterangan_arr, cell_style: { size: size_cell, height: height_nested, valign: :center }, width: width_nested)
    header_tabel_usulan << [
                              { content: i.to_s, width: 20, align: :center, valign: :center, rowspan: rowspan },
                              usulan_table, { content: pk.nama_subkegiatan, valign: :center, rowspan: rowspan },
                              { content: pk.nama_program, valign: :center, rowspan: rowspan },
                              { content: "Rp. #{number_with_delimiter(pk.my_pagu)}", width: 90, valign: :center, rowspan: rowspan },
                              { content: pk.opd.nama_opd, valign: :center, rowspan: rowspan },
                              lokasi_table, keterangan_table
                            ]
  end
  footer_tabel_usulan = ['', '', '', '', 'Jumlah', "Rp. #{number_with_delimiter(@program_kegiatans.map(&:my_pagu).compact.sum)}", '', '']
  header_tabel_usulan << footer_tabel_usulan
  pdf.table(header_tabel_usulan, cell_style: { size: size_cell }, width: pdf.bounds.width)
end
