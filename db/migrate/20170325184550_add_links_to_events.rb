class AddLinksToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :posterlink, :string
    add_column :events, :videolink, :string
  end
end
