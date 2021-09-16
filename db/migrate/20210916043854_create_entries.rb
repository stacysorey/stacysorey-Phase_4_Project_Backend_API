class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.string :title
      t.text :description
      t.date :date
      t.belongs_to :journal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
