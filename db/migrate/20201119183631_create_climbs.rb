class CreateClimbs < ActiveRecord::Migration[6.0]
  def change
    create_table :climbs do |t|
      t.integer :route_id
      t.string :name
      t.string :type
      t.string :rating
      t.string :stars
      t.string :location, array: true
      t.decimal :latitude
      t.decimal :longitude
      t.boolean :ticklist
      t.integer :user_id

      t.timestamps
    end
  end
end
