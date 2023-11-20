class CreateDucks < ActiveRecord::Migration[7.1]
  def change
    create_table :ducks do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
