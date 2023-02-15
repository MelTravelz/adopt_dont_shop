class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip, default: 5
      t.string :description
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
