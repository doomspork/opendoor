class Listing < ActiveRecord::Base
  def to_geo_json
    {
      "type": "Feature",
      "geometry": {"type": "Point", "coordinates": [lat, lng]},
      "properties": {
        "id": id,
        "price": price,
        "street": street,
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
        "sq_ft": sq_ft
      }
    }
  end
end
