class ApplicationController < ActionController::Base

  puts "Aucune structure définie ..." if Structure.all.count.zero?

end
