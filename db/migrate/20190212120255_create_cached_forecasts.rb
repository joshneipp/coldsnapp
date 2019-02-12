class CreateCachedForecasts < ActiveRecord::Migration[5.2]
  def change
    create_table :cached_forecasts do |t|
      t.string :zip_code
      t.text :low_temperatures

      t.timestamps
    end
  end
end
