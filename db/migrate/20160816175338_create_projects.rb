class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.text :genius
      t.string :projectname
      t.boolean :completed
      t.text :description
      t.string :comment
      t.boolean :appstore

      t.timestamps
    end
  end
end
