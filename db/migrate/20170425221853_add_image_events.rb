class AddImageEvents < ActiveRecord::Migration
  def change
  	add_column :events, :image, :attachment
  end
end
