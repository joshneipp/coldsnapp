class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    add_column :users, :sms_number, :string
    add_column :users, :sms_sent_at, :datetime
    add_column :users, :sms_verification_code, :string
  end
end
