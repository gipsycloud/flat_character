# json.extract! room, :id, :created_at, :updated_at
json.extract! room, :latitude, :longitude
json.label room.roomType
json.tooltip room.address
json.url room_url(room, format: :json)
