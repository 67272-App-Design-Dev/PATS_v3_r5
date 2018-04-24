json.array!(@dosages) do |dosage|
  json.extract! dosage, :id, :medicine_id, :visit_id, :units_given, :discount, :medicine_name
  json.url dosage_url(dosage, format: :json)
end