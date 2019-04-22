class CreateWorkspaces < ActiveRecord::Migration[5.2]
  def change
    create_table :workspaces do |t|
      t.string :label
      t.string :description
      t.string :context
      t.boolean :public

      t.timestamps
    end
  end
end
