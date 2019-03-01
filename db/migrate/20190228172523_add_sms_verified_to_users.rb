class AddSmsVerifiedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sms_verified, :boolean, default: false
  end
end
