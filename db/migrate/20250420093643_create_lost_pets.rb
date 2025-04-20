class CreateLostPets < ActiveRecord::Migration[6.1]
  def change
    create_table :lost_pets do |t|
      t.string :title
      t.string :name
      t.integer :gender, default: 2
      t.string :animal_type
      t.text :feature
      t.text :description
      t.date :missing_date
      t.string :last_seen_location
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
