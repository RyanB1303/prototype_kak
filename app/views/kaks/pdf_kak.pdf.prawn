prawn_document do |pdf|
  pdf.text 'KERANGKA ACUAN KERJA/ TERM OF REFERENCE', size: 16, align: :center
  pdf.text 'KELUARAN (OUTPUT) KEGIATAN TA 2022', align: :center
  # tabel pertama
  pdf.move_down 20
  tabel_program_kegiatan = [
    ['Kementrian negara/Lembaga', ':', 'Pemerintah Daerah Kota Madiun'],
    ['Unit Eselon I/II', ':', 'Badan Perencanaan, Penelitian dan Pengembangan Daerah'],
    ['Program', ':', @kak.program_kegiatan.nama_program],
    ['Kegiatan', ':', @kak.program_kegiatan.nama_kegiatan],
    ['Indikator', ':',@kak.program_kegiatan.indikator_kinerja],
    ['Target', ':', @kak.program_kegiatan.target],
    ['Satuan', ':', @kak.program_kegiatan.satuan],
    ['Sub Kegiatan', ':', { content: @kak.program_kegiatan.nama_subkegiatan, font_style: :bold }],
    ['Indikator', ':', @kak.program_kegiatan.indikator_subkegiatan],
    ['Target', ':', "#{@kak.program_kegiatan.target_subkegiatan} #{@kak.program_kegiatan.satuan_target_subkegiatan}"]
  ]
  pdf.table(tabel_program_kegiatan, cell_style: { size: 8 })
  pdf.move_down 20
  pdf.text 'A. Latar Belakang', size: 14, style: :bold
  pdf.move_down 5
  pdf.text '1. Dasar Hukum', indent_paragraphs: 5, size: 12, style: :bold
  pdf.move_down 5
  @kak.dasar_hukum.each do |hukum|
    pdf.bounding_box([30, pdf.cursor], width: 450) do
      pdf.text hukum.to_s, align: :justify, size: 8
    end
  end
  pdf.move_down 5
  pdf.text '2. Gambaran Umum', indent_paragraphs: 5, size: 12, style: :bold
  pdf.move_down 5
  pdf.bounding_box([30, pdf.cursor], width: 450) do
    pdf.text @kak.gambaran_umum, align: :justify, size: 8
  end

  pdf.move_down 20
  pdf.text 'B. Penerima Manfaat', size: 14, style: :bold
  data_penerima_manfaat = [['No', 'Rencana Kinerja', 'Penerima Manfaat', 'Nama Usulan',
                            'Jenis Usulan', 'Alamat', 'Cek Lokasi', 'Keterangan']]
  @kak.program_kegiatan.sasarans.each.with_index(1).map do |sasaran, i|
    data_penerima_manfaat << [i.to_s, sasaran.sasaran_kinerja.to_s, sasaran.penerima_manfaat.to_s, 'Usulan Contoh',
                              'Musrenbang', 'Alamat ABC', '111111', '']
  end
  pdf.move_down 10
  pdf.table(data_penerima_manfaat, cell_style: { size: 8 })

  pdf.move_down 20
  pdf.text 'C. Strategi Pencapaain Keluaran', size: 14, style: :bold
  # sasaran 1
  pdf.move_down 10
  @kak.program_kegiatan.sasarans.order(:created_at).each.with_index(1) do |sasaran, index|
    data_rencana_aksi = [[{ content: 'No', rowspan: 2 }, { content: 'Tahapan Kerja', rowspan: 2 }, { content: 'Target pada bulan', colspan: 12 }, { content: 'Jumlah', rowspan: 2 },
                          { content: 'Pagu Anggaran', rowspan: 2 }, { content: 'Keterangan', rowspan: 2 }],
                         %w[1 2 3 4 5 6 7 8 9 10 11 12]]
    pdf.text "Sasaran #{index}:   #{sasaran.sasaran_kinerja}", size: 12, style: :bold
    pdf.move_down 7

    sasaran.tahapans.each.with_index(1) do |tahapan, i|
      data_rencana_aksi << [i, tahapan.tahapan_kerja,
                            tahapan.find_target_bulan(1),
                            tahapan.find_target_bulan(2),
                            tahapan.find_target_bulan(3),
                            tahapan.find_target_bulan(4),
                            tahapan.find_target_bulan(5),
                            tahapan.find_target_bulan(6),
                            tahapan.find_target_bulan(7),
                            tahapan.find_target_bulan(8),
                            tahapan.find_target_bulan(9),
                            tahapan.find_target_bulan(10),
                            tahapan.find_target_bulan(11),
                            tahapan.find_target_bulan(12),
                            tahapan.target_total,
                            "Rp. #{number_with_delimiter(tahapan.anggaran_tahapan, delimiter: '.')}",
                            tahapan.keterangan]
    end
    data_rencana_aksi << [{ content: "Total sasaran ini adalah #{sasaran.waktu_total} bulan", colspan: 14 },
                          sasaran.jumlah_target, "Rp. #{number_with_delimiter(sasaran.total_anggaran, delimiter: '.')}", '']
    pdf.table(data_rencana_aksi, cell_style: { size: 8 })
    data_rencana_aksi.clear
    pdf.move_down 10
  end
  pdf.move_down 10
  pdf.text "Total waktu yang diperlukan dalama pencapaian output sub kegiatan ini adalah #{@kak.program_kegiatan.my_waktu} bulan", size: 8
  pdf.move_down 20
  pdf.text 'D. Pagu Anggaran', size: 14, style: :bold
  pdf.move_down 10
  pdf.text "Pagu Anggaran yang diperlukan dalam sub kegiatan ini, adalah sebesar Rp. #{number_with_delimiter(@kak.program_kegiatan.my_pagu, delimiter: '.')}", size: 8
end
