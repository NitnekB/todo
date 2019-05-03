class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.string :state
      t.references :project, index: true, foreign_key: true

      t.timestamps
    end
  end
end
