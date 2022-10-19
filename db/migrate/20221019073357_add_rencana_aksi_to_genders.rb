class AddRencanaAksiToGenders < ActiveRecord::Migration[6.1]
  def change
    add_column :genders, :rencana_aksi, :string
    add_column :genders, :rencana_aksi_id, :string
  end
end
