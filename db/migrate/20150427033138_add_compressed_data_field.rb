class AddCompressedDataField < ActiveRecord::Migration
  def change
    add_column :gestures, :compressed_data, :string
  end
end
