class AddAddressLatitudeLongitudeToLostPets < ActiveRecord::Migration[6.1]
  def change
    add_column :lost_pets, :address, :string, null: false, default: ""
    add_column :lost_pets, :latitude, :float, null: true 
    add_column :lost_pets, :longitude, :float, null: true 
  end
end
