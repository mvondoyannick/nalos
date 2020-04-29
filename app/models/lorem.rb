class Lorem < ApplicationRecord

  def self.import(file)

    require 'csv'
    current = []

    CSV.foreach(file.path, headers: true) do |row|
      # Lorem.create! row.to_hash
      puts row[0]
      current << Lorem.create!(row.to_h)
    end
    puts current.to_json
  end

end
