json.array!(@people) do |person|
  json.extract! person, :name, :bio, :birthday
  json.url person_url(person, format: :json)
end
