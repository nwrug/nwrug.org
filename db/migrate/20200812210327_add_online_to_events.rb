class AddOnlineToEvents < ActiveRecord::Migration
  def change
    add_column :events, :online, :boolean, default: false
  end
end
