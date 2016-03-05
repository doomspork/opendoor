require 'csv'
require 'rake'

require_relative '../listing'

namespace :opendoor do
  task :import, [:path] do |t, args|
    opts = {converters: :all, headers: true, header_converters: :symbol}
    CSV.foreach(args.path, opts) do |row|
      listing = Listing.new(row.to_hash)
      listing.save
    end
  end
end
