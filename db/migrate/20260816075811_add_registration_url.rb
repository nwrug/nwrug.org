class AddRegistrationUrl < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :registration_url, :string
  end
end
