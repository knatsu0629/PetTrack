class AddZipcodeToLostPets < ActiveRecord::Migration[6.1]
  def change
    add_column :lost_pets, :zipcode, :string
  end
end
