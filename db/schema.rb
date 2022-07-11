# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_220_417_070_528) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index %w[record_type record_id name], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index %w[record_type record_id name blob_id], name: "index_active_storage_attachments_uniqueness",
                                                    unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index %w[blob_id variation_digest], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "aksis", force: :cascade do |t|
    t.integer "target"
    t.integer "realisasi"
    t.integer "bulan"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "tahapan_id"
    t.string "id_rencana_aksi"
    t.string "id_aksi_bulan"
    t.index ["id_aksi_bulan"], name: "index_aksis_on_id_aksi_bulan", unique: true
    t.index ["tahapan_id"], name: "index_aksis_on_tahapan_id"
  end

  create_table "anggaran_hspks", force: :cascade do |t|
    t.string "kode_kelompok_barang"
    t.string "uraian_kelompok_barang"
    t.string "kode_barang"
    t.string "uraian_barang"
    t.string "spesifikasi"
    t.string "satuan"
    t.bigint "harga_satuan"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "anggaran_sbus", force: :cascade do |t|
    t.string "kode_kelompok_barang"
    t.string "uraian_kelompok_barang"
    t.string "kode_barang"
    t.string "uraian_barang"
    t.string "spesifikasi"
    t.string "satuan"
    t.bigint "harga_satuan"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "anggaran_sshes", force: :cascade do |t|
    t.string "kode_kelompok_barang"
    t.string "uraian_kelompok_barang"
    t.string "kode_barang"
    t.string "uraian_barang"
    t.string "spesifikasi"
    t.string "satuan"
    t.bigint "harga_satuan"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "anggarans", force: :cascade do |t|
    t.string "kode_rek"
    t.text "uraian"
    t.integer "jumlah"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "tahapan_id"
    t.integer "level", default: 0
    t.bigint "parent_id"
    t.bigint "pajak_id"
    t.string "set_input", default: "0"
    t.integer "tahun"
    t.index ["pajak_id"], name: "index_anggarans_on_pajak_id"
    t.index ["parent_id"], name: "index_anggarans_on_parent_id"
    t.index ["tahapan_id"], name: "index_anggarans_on_tahapan_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "head"
    t.text "body", null: false
    t.bigint "anggaran_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["anggaran_id"], name: "index_comments_on_anggaran_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "dasar_hukums", force: :cascade do |t|
    t.text "peraturan"
    t.string "judul"
    t.string "tahun"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  # Could not dump table "inovasis" because of following StandardError
  #   Unknown type 'usulan_status' for column 'status'

  create_table "kaks", force: :cascade do |t|
    t.text "dasar_hukum", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "program_kegiatan_id"
    t.text "gambaran_umum"
    t.text "penerima_manfaat"
    t.text "metode_pelaksanaan"
    t.text "tahapan_pelaksanaan"
    t.text "waktu_dibutuhkan"
    t.text "biaya_diperlukan"
    t.index ["program_kegiatan_id"], name: "index_kaks_on_program_kegiatan_id"
  end

  create_table "kesenjangans", force: :cascade do |t|
    t.bigint "rincian_id", null: false
    t.string "akses"
    t.string "partisipasi"
    t.string "kontrol"
    t.string "manfaat"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rincian_id"], name: "index_kesenjangans_on_rincian_id"
  end

  create_table "koefisiens", force: :cascade do |t|
    t.integer "volume"
    t.string "satuan_volume"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "perhitungan_id"
    t.index ["perhitungan_id"], name: "index_koefisiens_on_perhitungan_id"
  end

  create_table "latar_belakangs", force: :cascade do |t|
    t.text "dasar_hukum"
    t.text "gambaran_umum"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lembagas", force: :cascade do |t|
    t.string "nama_lembaga"
    t.string "tahun"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  # Could not dump table "mandatoris" because of following StandardError
  #   Unknown type 'usulan_status' for column 'status'

  # Could not dump table "musrenbangs" because of following StandardError
  #   Unknown type 'usulan_status' for column 'status'

  create_table "opds", force: :cascade do |t|
    t.string "nama_opd"
    t.string "kode_opd"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "lembaga_id"
    t.integer "id_opd_skp"
    t.string "kode_unik_opd"
    t.string "urusan"
    t.string "bidang_urusan"
    t.string "kode_urusan"
    t.string "kode_bidang_urusan"
    t.index ["kode_opd"], name: "index_opds_on_kode_opd", unique: true
  end

  create_table "pagus", force: :cascade do |t|
    t.string "item"
    t.integer "uang"
    t.string "tipe"
    t.string "satuan"
    t.integer "volume"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "total"
  end

  create_table "pajaks", force: :cascade do |t|
    t.string "tahun"
    t.string "tipe"
    t.float "potongan"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "perhitungans", force: :cascade do |t|
    t.integer "volume"
    t.string "satuan"
    t.integer "harga"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "anggaran_id"
    t.integer "total"
    t.string "deskripsi"
    t.text "spesifikasi"
    t.index ["anggaran_id"], name: "index_perhitungans_on_anggaran_id"
  end

  # Could not dump table "pokpirs" because of following StandardError
  #   Unknown type 'usulan_status' for column 'status'

  create_table "program_kegiatans", force: :cascade do |t|
    t.string "nama_program"
    t.string "nama_kegiatan"
    t.string "nama_subkegiatan"
    t.string "indikator_kinerja"
    t.string "target"
    t.string "satuan"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "subkegiatan_tematik_id"
    t.string "indikator_subkegiatan"
    t.string "target_subkegiatan"
    t.string "satuan_target_subkegiatan"
    t.string "kode_opd"
    t.string "indikator_program"
    t.string "target_program"
    t.string "satuan_target_program"
    t.string "id_unit"
    t.string "kode_urusan"
    t.string "nama_urusan"
    t.string "kode_bidang_urusan"
    t.string "nama_bidang_urusan"
    t.string "id_program_sipd"
    t.string "kode_program"
    t.string "kode_giat"
    t.string "id_sub_giat"
    t.string "kode_sub_giat"
    t.string "pagu"
    t.string "identifier_belanja"
    t.index ["subkegiatan_tematik_id"], name: "index_program_kegiatans_on_subkegiatan_tematik_id"
  end

  create_table "programs", force: :cascade do |t|
    t.string "id_program"
    t.string "tahun"
    t.string "kode_program"
    t.string "nama_program"
    t.string "id_unik"
    t.string "indikator"
    t.string "satuan"
    t.string "target"
    t.string "nama_urusan"
    t.string "nama_bidang_urusan"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rekenings", force: :cascade do |t|
    t.string "kode_rekening"
    t.string "jenis_rekening"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "set_input", default: 0
  end

  create_table "rincians", force: :cascade do |t|
    t.bigint "sasaran_id", null: false
    t.string "data_terpilah"
    t.string "penyebab_internal"
    t.string "penyebab_external"
    t.string "permasalahan_umum"
    t.string "permasalahan_gender"
    t.string "resiko"
    t.string "lokasi_pelaksanaan"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sasaran_id"], name: "index_rincians_on_sasaran_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index %w[name resource_type resource_id], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index %w[resource_type resource_id], name: "index_roles_on_resource"
  end

  create_table "sasarans", force: :cascade do |t|
    t.string "sasaran_kinerja"
    t.string "indikator_kinerja"
    t.integer "target"
    t.integer "kualitas"
    t.string "satuan"
    t.string "penerima_manfaat"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "program_kegiatan_id"
    t.integer "anggaran"
    t.string "nip_asn"
    t.string "id_rencana"
    t.index ["id_rencana"], name: "index_sasarans_on_id_rencana", unique: true
    t.index ["program_kegiatan_id"], name: "index_sasarans_on_program_kegiatan_id"
  end

  create_table "strategi_keluarans", force: :cascade do |t|
    t.text "metode"
    t.text "tahapan"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subkegiatan_tematiks", force: :cascade do |t|
    t.string "nama_tematik"
    t.string "kode_tematik"
    t.string "tahun"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subkegiatan_priorities", force: :cascade do |t|
    t.string "nama_priority"
    t.string "kode_priority"
    t.string "tahun"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tahapans", force: :cascade do |t|
    t.string "tahapan_kerja"
    t.integer "target"
    t.integer "realisasi"
    t.string "bulan"
    t.integer "jumlah_target"
    t.integer "jumlah_realisasi"
    t.string "keterangan"
    t.integer "waktu"
    t.integer "progress"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "sasaran_id"
    t.string "id_rencana_aksi"
    t.string "id_rencana"
    t.index ["id_rencana_aksi"], name: "index_tahapans_on_id_rencana_aksi", unique: true
    t.index ["sasaran_id"], name: "index_tahapans_on_sasaran_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nama"
    t.string "nik"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "kode_opd"
    t.string "pangkat"
    t.string "jabatan"
    t.string "eselon"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nik"], name: "index_users_on_nik", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index %w[user_id role_id], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "usulans", force: :cascade do |t|
    t.string "keterangan"
    t.string "usulanable_type"
    t.bigint "usulanable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "sasaran_id"
    t.index ["sasaran_id"], name: "index_usulans_on_sasaran_id"
    t.index %w[usulanable_type usulanable_id], name: "index_usulans_on_usulanable"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "anggarans", "pajaks"
  add_foreign_key "comments", "anggarans"
  add_foreign_key "comments", "users"
  add_foreign_key "kesenjangans", "rincians"
  add_foreign_key "program_kegiatans", "opds", column: "kode_opd", primary_key: "kode_opd"
  add_foreign_key "program_kegiatans", "subkegiatan_tematiks"
  add_foreign_key "rincians", "sasarans"
  add_foreign_key "sasarans", "users", column: "nip_asn", primary_key: "nik"
  add_foreign_key "users", "opds", column: "kode_opd", primary_key: "kode_opd"

  create_view "search_all_usulans", sql_definition: <<-SQL
      SELECT musrenbangs.usulan,
      musrenbangs.sasaran_id,
      'Musrenbang'::text AS searchable_type,
      musrenbangs.id AS searchable_id
     FROM musrenbangs
    WHERE (musrenbangs.is_active = true)
  UNION
   SELECT pokpirs.usulan,
      pokpirs.sasaran_id,
      'Pokpir'::text AS searchable_type,
      pokpirs.id AS searchable_id
     FROM pokpirs
    WHERE (pokpirs.is_active = true)
  UNION
   SELECT mandatoris.usulan,
      mandatoris.sasaran_id,
      'Mandatori'::text AS searchable_type,
      mandatoris.id AS searchable_id
     FROM mandatoris
    WHERE (mandatoris.is_active = true)
  UNION
   SELECT inovasis.usulan,
      inovasis.sasaran_id,
      'Inovasi'::text AS searchable_type,
      inovasis.id AS searchable_id
     FROM inovasis
    WHERE (inovasis.is_active = true);
  SQL
  create_view "search_all_anggarans", sql_definition: <<-SQL
      SELECT anggaran_sshes.uraian_barang,
      anggaran_sshes.kode_barang,
      anggaran_sshes.spesifikasi,
      anggaran_sshes.satuan,
      anggaran_sshes.harga_satuan,
      'AnggaranSsh'::text AS searchable_type,
      anggaran_sshes.id AS searchable_id
     FROM anggaran_sshes
  UNION
   SELECT anggaran_sbus.uraian_barang,
      anggaran_sbus.kode_barang,
      anggaran_sbus.spesifikasi,
      anggaran_sbus.satuan,
      anggaran_sbus.harga_satuan,
      'AnggaranSbu'::text AS searchable_type,
      anggaran_sbus.id AS searchable_id
     FROM anggaran_sbus
  UNION
   SELECT anggaran_hspks.uraian_barang,
      anggaran_hspks.kode_barang,
      anggaran_hspks.spesifikasi,
      anggaran_hspks.satuan,
      anggaran_hspks.harga_satuan,
      'AnggaranHspk'::text AS searchable_type,
      anggaran_hspks.id AS searchable_id
     FROM anggaran_hspks;
  SQL
end
