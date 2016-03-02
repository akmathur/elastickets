class CreateExtensions < ActiveRecord::Migration
  def change
    create_table :extensions do |t|
      t.string :target_model
      t.integer :position
      t.string :label
      t.string :attr_name
      t.string :attr_type
      t.text :values
      t.string :default
      t.boolean :is_required

      t.timestamps null: false
    end
  end
end
