json.array!(@map_rooms) do |room|
  json.latitude room.latitude
  json.longitude room.longitude
  json.label room.roomType
  json.tooltip html_link_to_home(room)
  json.address room.address
  # json.url room__url(room, format: :json)
end


# json.array! @homes, partial: "homes/home", as: :home
