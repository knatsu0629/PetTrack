json.data do

  json.items do
    json.array!(@lost_pets) do |lost_pet|
      json.id lost_pet.id


      json.user do
        json.name lost_pet.user.name
        if lost_pet.user.avatar.attached?
          json.image url_for(lost_pet.user.avatar.variant(resize: "40x40"))
        else
          json.image nil
        end
      end

      json.name lost_pet.name
      json.gender lost_pet.gender
      json.feature lost_pet.feature
      json.description lost_pet.description

      json.latitude lost_pet.latitude.to_f
      json.longitude lost_pet.longitude.to_f

    end
  end
end