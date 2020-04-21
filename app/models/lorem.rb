class Lorem < ApplicationRecord

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Lorem.create! row.to_hash
    end
  end

end
