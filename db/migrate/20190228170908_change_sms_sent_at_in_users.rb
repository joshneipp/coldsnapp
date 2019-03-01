class ChangeSmsSentAtInUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :sms_sent_at
    add_column :users, :sms_verification_sent_at, :datetime
  end
end
