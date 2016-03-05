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

  def self.search(params = {})
    query = Listing.order(:id)

    query = query.where('price >= ?', params[:min_price]) if params[:min_price]
    query = query.where('price <= ?', params[:max_price]) if params[:max_price]

    query = query.where('bedrooms <= ?', params[:max_bed]) if params[:max_bed]
    query = query.where('bedrooms >= ?', params[:min_bed]) if params[:min_bed]

    query = query.where('bathrooms <= ?', params[:max_bath]) if params[:max_bath]
    query = query.where('bathrooms >= ?', params[:min_bath]) if params[:min_bath]

    query.paginate(page: params[:page], per_page: 100)
  end
end
