class CreateLostPetTags < ActiveRecord::Migration[6.1]
    unless table_exists?(:lost_pet_tags)
      create_table :lost_pet_tags do |t|
        t.references :lost_pet, null: false, foreign_key: true
        t.references :tag, null: false, foreign_key: true

        t.timestamps
      end
  end
end
