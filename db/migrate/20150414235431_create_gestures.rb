class CreateGestures < ActiveRecord::Migration
  def change
    create_table :gestures do |t|
      t.string :title

      t.timestamps
    end
  end
end
