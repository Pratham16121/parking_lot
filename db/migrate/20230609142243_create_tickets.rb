class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.references :car, null: false, foreign_key: true
      t.integer :assigned_slot
      t.boolean :is_deleted, default: false

      t.timestamps
    end
  end
end
