class RemoveLatitudeAndLongitudeFromLostPets < ActiveRecord::Migration[6.1]
  def change
    remove_column :lost_pets, :latitude, :decimal
    remove_column :lost_pets, :longitude, :decimal
  end
end
