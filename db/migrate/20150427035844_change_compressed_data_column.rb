class ChangeCompressedDataColumn < ActiveRecord::Migration
  def change
    change_column :gestures, :compressed_data, :text, :limit => nil
  end
end
