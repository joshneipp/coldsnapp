class AddNextForecastCheckToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :next_forecast_check_time, :datetime
  end
end
