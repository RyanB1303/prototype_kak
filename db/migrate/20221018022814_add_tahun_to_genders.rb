class AddTahunToGenders < ActiveRecord::Migration[6.1]
  def change
    add_column :genders, :tahun, :string
  end
end
