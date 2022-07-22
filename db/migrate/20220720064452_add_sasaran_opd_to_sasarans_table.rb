class AddSasaranOpdToSasaransTable < ActiveRecord::Migration[6.1]
  def change
    add_column :sasarans, :type, :string, null: true
    add_column :sasarans, :sasaran_opd, :string, null: true
  end
end
