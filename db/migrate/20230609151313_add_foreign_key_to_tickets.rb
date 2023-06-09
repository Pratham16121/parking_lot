class AddForeignKeyToTickets < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :tickets, :slots, column: :assigned_slot
  end
end
  