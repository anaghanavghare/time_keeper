class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :doc_name
      t.integer :timeframe

      t.timestamps
    end
  end
end
