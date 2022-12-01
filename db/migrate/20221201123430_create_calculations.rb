class CreateCalculations < ActiveRecord::Migration[7.0]
  def change
    create_table :calculations do |t|
      t.text :array
      t.text :max_seg
      t.text :segments
      t.integer :seg_count

      t.timestamps
    end
  end
end
