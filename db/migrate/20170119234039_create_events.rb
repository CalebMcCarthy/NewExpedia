class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :info
      t.string :location
      t.date :time
      t.attachment :image
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
