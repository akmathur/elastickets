class AddExtendedAttrsToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :extended_attrs, :text
  end
end
