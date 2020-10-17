class CreateUserJob < ApplicationJob
  queue_as :default

  def perform(args)
    # Do something later
    name = args[:name]
    email = args[:email]
    password = 123456
    structure_id = args[:structure_id]
    role_id = Role.find_by_name('admin').id
    matricule = SecureRandom.hex(6).upcase

    # begin save
    u = User.new(name: name, email: email, password: password, structure_id: structure_id, role_id: role_id, matricule: matricule)
    if u.save
      puts 'saved'
    else
      puts u.errors.details
    end
  end
end
