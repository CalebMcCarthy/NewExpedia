class Addimgaestousers < ActiveRecord::Migration
  def change
  		add_column :users, :image, :attachment
  end
end
