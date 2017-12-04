class CreateMarks < ActiveRecord::Migration[5.0]
  def change
    create_table :marks do |t|
      t.string :uid, null: false
      t.integer :sop_id, null: false
    end
  end
end
