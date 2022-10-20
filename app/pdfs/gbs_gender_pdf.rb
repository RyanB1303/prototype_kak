class GapGenderPdf < Prawn::Document
  include ActionView::Helpers::NumberHelper

  def initialize(opd: '', tahun: '', gender: '')
    super page_layout: :landscape, page_size: "LETTER"
    @opd = opd
    @tahun = tahun
    @nama_opd = @opd.nama_opd
    @kota = @opd.lembaga.nama_lembaga
    @gender = gender
    @program_kegiatan = @gender.program_kegiatan
    print
  end

  def print
    title
    move_down 20
    tabel_gender(gender)
    move_down 10
    ttd
  end

  def title
    text "PERNYATAAN ANGGARAN GENDER", align: :center
    move_down 3
    text "(GENDER BUDGET STATEMENT)", align: :center
    move_down 3
    text @nama_opd.upcase, align: :center
    move_down 3
    text "Tahun: #{@tahun}", align: :center
  end

  def ttd
    start_new_page if (cursor - 125).negative?
    bounding_box([bounds.width - 370, cursor - 5], width: bounds.width - 200) do
      text "Madiun,    #{I18n.l Date.today, format: '  %B %Y'}", size: 8, align: :center
      move_down 5
      text "<strong>#{@opd.jabatan_kepala_tanpa_opd}</strong>", size: 8, align: :center,
                                                                inline_format: true
      text "<strong>#{@opd.nama_opd}</strong>", size: 8, align: :center, inline_format: true
      move_down 50
      text "<u>#{@opd.nama_kepala || '!!belum disetting'}</u>", size: 8, align: :center,
                                                                inline_format: true
      text @opd.pangkat_kepala || '!! belum disetting', size: 8, align: :center
      text "NIP. #{@opd.nip_kepala_fix_plt || '!! belum disetting'}", size: 8, align: :center
    end
  end

  def header_tabel
    [[{ content: "KEBIJAKAN / PROGRAM / KEGIATAN / SUBKEGIATAN", rowspan: 2, width: 70 },
      { content: "DATA PEMBUKA WAWASAN", align: :center, rowspan: 2, width: 70 },
      { content: "ISU GENDER", colspan: 3, align: :center },
      { content: "KEBIJAKAN DAN RENCANA KEDEPAN", colspan: 2, align: :center },
      { content: "PENGUKURAN HASIL", colspan: 2, align: :center }],
     [{ content: "FAKTOR KESENJANGAN", width: 70, align: :center },
      { content:  "SEBAB INTERNAL", width: 70, align: :center },
      { content:  "SEBAB EXTERNAL", width: 70, align: :center },
      { content:  "REFORMULASI TUJUAN", width: 70, align: :center },
      { content:  "RENCANA AKSI", width: 70, align: :center },
      { content:  "BASELINE", width: 70, align: :center },
      { content:  "INDIKATOR", width: 70, align: :center }],
     [{ content: "1", width: 70, align: :center },
      { content:  "2", width: 70, align: :center },
      { content:  "3", width: 70, align: :center },
      { content:  "4", width: 70, align: :center },
      { content:  "5", width: 70, align: :center },
      { content:  "6", width: 70, align: :center },
      { content:  "7", width: 70, align: :center },
      { content:  "8", width: 70, align: :center },
      { content:  "9", width: 70, align: :center }]]
  end

  def gender
    # main table
    data_gender = header_tabel
    data_gender << [{ content: @gender.program_kegiatan_subkegiatan },
                    { content: @gender.data_pembuka_wawasan },
                    { content: @gender.faktor_kesenjangan },
                    { content: @gender.penyebab_internal_non_html },
                    { content: @gender.penyebab_external_non_html },
                    { content: @gender.reformulasi_tujuan },
                    { content: @gender.rencana_aksi_tahapan },
                    { content: @gender.data_baseline },
                    { content: @gender.indikator_gender }]
    # create cell
  end

  def gbs
    cell_pembuka_wawasan = []
    cell_penyebab_internal = []
    cell_penyebab_external = []
    @program_kegiatan.rincians.each do |rincian|
      cell_pembuka_wawasan << ['-', rincian&.data_terpilah || '-']
    end
    @program_kegiatan.permasalahans.each do |masalah|
      cell_penyebab_internal << ['-', masalah&.penyebab_internal || '-']
      cell_penyebab_external << ['-', masalah&.penyebab_external || '-']
    end
    # width table, the table_subtable is the first child
    # the subtable is the 2nd child table
    table_subtable_width = pdf.bounds.width - 70
    col_0_subtable_width = 12
    subtable_width = table_subtable_width - 32

    tabel_pembuka_wawasan = pdf.make_table(cell_pembuka_wawasan,
                                           cell_style: { size: 8, border_width: 0 },
                                           column_widths: { 0 => col_0_subtable_width, 1 => subtable_width })

    tabel_faktor_kesenjangan = pdf.make_table([
                                                ['-', '-']
                                              ],
                                              cell_style: { size: 8, border_width: 0 })

    tabel_internal = pdf.make_table(cell_penyebab_internal,
                                    cell_style: { size: 8, border_width: 0 },
                                    column_widths: { 0 => col_0_subtable_width, 1 => subtable_width })

    tabel_external = pdf.make_table(cell_penyebab_external,
                                    cell_style: { size: 8, border_width: 0 },
                                    column_widths: { 0 => col_0_subtable_width, 1 => subtable_width })
    tabel_kesenjangan = pdf.make_table([
                                         ['1.', { content: 'Data Pembuka Wawasan' }],
                                         ['', tabel_pembuka_wawasan],
                                         ['2.', { content: 'Isu dan Faktor Kesenjangan Gender' }],
                                         ['', 'a. Faktor Kesenjangan'],
                                         ['', tabel_faktor_kesenjangan],
                                         ['', 'b. Penyebab Internal'],
                                         ['', tabel_internal],
                                         ['', 'c. Penyebab Eksternal'],
                                         ['', tabel_external]
                                       ],
                                       cell_style: { size: 8, border_width: 0 },
                                       column_widths: { 0 => 20 }, width: table_subtable_width)
    tabel_capaian_program = pdf.make_table([
                                             ['1.', { content: 'Tolok Ukur' }],
                                             ['', 'Tujuan Program'],
                                             ['2.', 'Indikator Kinerja dan Target Kinerja'],
                                             ['-',
                                              "#{@program_kegiatan.indikator_program} #{@program_kegiatan.target_program} #{@program_kegiatan.satuan_target_program}"]
                                           ],
                                           cell_style: { size: 8, border_width: 0 },
                                           column_widths: { 0 => 20 }, width: table_subtable_width)
    tabel_rencana_aksi = pdf.make_table([
                                          [{ content: 'Kegiatan', rowspan: 5, borders: [:right], border_width: 0 }],
                                          [@program_kegiatan.nama_kegiatan || '-'],
                                          ["Masukan: Rp. #{number_with_delimiter(@program_kegiatan.pagu) || 0}"],
                                          ["Keluaran: #{@program_kegiatan.indikator_kinerja}"],
                                          ["Hasil: #{@program_kegiatan.target} #{@program_kegiatan.satuan}"],
                                          [{ content: 'Sub Kegiatan', rowspan: 5, borders: [:right], border_width: 0 }],
                                          [@program_kegiatan.nama_kegiatan || '-'],
                                          ["Masukan: Rp. #{number_with_delimiter(@program_kegiatan.pagu) || 0}"],
                                          ["Keluaran: #{@program_kegiatan.indikator_subkegiatan}"],
                                          ["Hasil: #{@program_kegiatan.target_subkegiatan} #{@program_kegiatan.satuan_target_subkegiatan}"]
                                        ],
                                        cell_style: { size: 8, border_width: 0 }, width: table_subtable_width)
    tabel_program_kegiatan = [
      ['SKPD', { content: @program_kegiatan.opd.nama_opd, font_style: :bold }],
      ['TAHUN ANGGARAN', { content: @program_kegiatan.tahun || 2023.to_s, font_style: :bold }],
      ['PROGRAM', { content: @program_kegiatan.nama_program }],
      ['KODE PROGRAM', { content: @program_kegiatan.kode_program }],
      [{ content: 'ANALISIS SITUASI' }, { content: tabel_kesenjangan }],
      ['CAPAIAN PROGRAM', tabel_capaian_program],
      ['JUMLAH ANGGARAN SUBKEGIATAN',
       { content: "Rp. #{number_with_delimiter(@program_kegiatan.pagu)}", font_style: :bold }],
      ['RENCANA AKSI', tabel_rencana_aksi]
    ]
    pdf.table(tabel_program_kegiatan,
              column_widths: { 0 => 70 },
              cell_style: { size: 8, border_width: 1 },
              width: pdf.bounds.width)
    # after tabel pertama
    pdf.move_down 30
  end

  private

  def tabel_gender(content_tabel)
    table(content_tabel, header: true) do
      cells.style(size: 8, inline_format: true)
    end
  end

  def tabel_maker(data)
    make_table(data, header: true) do
      cells.style(size: 8, inline_format: true)
    end
  end
end
