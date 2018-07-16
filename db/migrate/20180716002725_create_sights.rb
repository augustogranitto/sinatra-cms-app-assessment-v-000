class CreateSights < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.integer :country_id
      t.integer :user_id
    end
  end
end
