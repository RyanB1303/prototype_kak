class AddOpdToKepegawaians < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_reference_concurrently :kepegawaians, :opd, null: true, index: true
  end
end
