class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.string :word, null: false
      t.integer :count, default: 0

      t.index :word, unique: true

      t.timestamps
    end
  end
end
