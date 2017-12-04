class CreateSops < ActiveRecord::Migration[5.0]
  def change
    create_table :sops do |t|
      t.string :name, null: false
      t.string :desc, null: false
      t.string :author, null: false
      t.string :unit, null: false
      t.string :steps, null: false
      t.timestamps
    end
  end
end
