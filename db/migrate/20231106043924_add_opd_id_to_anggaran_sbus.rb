class AddOpdIdToAnggaranSbus < ActiveRecord::Migration[6.1]
  def change
    add_column :anggaran_sbus, :opd_id, :bigint, null: true
  end
end
