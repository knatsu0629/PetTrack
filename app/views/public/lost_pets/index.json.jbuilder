json.data do
  json.items do
    json.array!(@lost_pets) do |lost_pet|
      json.id lost_pet.id
      json.user do
        json.name lost_pet.user.name
        json.image url_for(lost_pet.user.profile_image) if lost_pet.user.profile_image.attached?
      end
      json.name lost_pet.name
      json.gender lost_pet.gender
      json.feature lost_pet.feature
      json.description lost_pet.description
      json.latitude lost_pet.latitude
    end
  end
end
