class CreateSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
      t.string :name
      t.integer :distance
      t.boolean :is_empty, default: true
      t.references :ticket, foreign_key: true

      t.timestamps
    end
  end
end
