json.array!(@medicines) do |medicine|
  json.extract! medicine, :id, :name, :description, :stock_amount, :admin_method, :unit, :vaccine, :active
  json.url medicine_url(medicine, format: :json)
end
