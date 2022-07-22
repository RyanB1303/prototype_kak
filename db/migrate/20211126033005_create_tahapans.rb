class CreateTahapans < ActiveRecord::Migration[6.1]
  def change
    create_table :tahapans do |t|
      t.string :tahapan_kerja
      t.integer :target
      t.integer :realisasi
      t.string :bulan
      t.integer :jumlah_target
      t.integer :jumlah_realisasi
      t.string :keterangan
      t.integer :waktu
      t.integer :progress

      t.timestamps
    end
  end
end
