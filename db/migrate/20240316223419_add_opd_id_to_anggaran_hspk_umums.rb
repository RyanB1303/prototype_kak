class AddOpdIdToAnggaranHspkUmums < ActiveRecord::Migration[6.1]
  def change
    add_column :anggaran_hspk_umums, :opd_id, :bigint, null: true
  end
end
