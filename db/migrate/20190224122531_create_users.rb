class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.json :settings

      t.timestamps
    end
  end
end
