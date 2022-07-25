class AddSasaranKotaToSasaransTable < ActiveRecord::Migration[6.1]
  def change
    add_column :sasarans, :sasaran_kota, :string, null: true
  end
end
