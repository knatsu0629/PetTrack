class CreateLostPetComments < ActiveRecord::Migration[6.1]
  def change
    create_table :lost_pet_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lost_pet, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
