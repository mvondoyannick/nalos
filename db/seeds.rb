# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# CourseStatus.create([{ name: 'waiting' }, { name: 'validate' }, { name: 'rejected' }]) if CourseStatus.all.count == 0
# puts 'Course status created'
#
# # role user
# Role.create!([{ name: "teacher" }, { name: "admin" }, { name: "ap" }, { name: "administration" }])
# puts 'Role created'
#
# # adding cycle ecole
# CycleEcole.create([{ name: "Francophone", code: "Fr", structure_id: 1 }, { name: "Englophone", code: "En", structure_id: 1 }]) if CycleEcole.all.count == 0
# puts 'Cycle Ecole created'
#
# # Automatisation des matieres
# Matiere.create([{ name: "Francais" }, { name: "English" }, { name: "Mathématique" }, { name: "Histoire" }, { name: "Géographie" }]) if Matiere.all.count == 0
# puts 'Matiere created'
#
# # automatisation des salle de classe
# # SalleDeClass.create([{ name: "Virtual", cycle_ecole_id: 1 }, { name: "Virtual2", cycle_ecole_id: 1 }, { name: "Virtual3", cycle_ecole_id: 1 }])
# puts 'Salle de classe created'
#
# # auto create Student
# # Student.create([{email: "nalos@nalos.com", password: 123456, sexe: "masculin", phone: 691451189, matricule: "007", salle_de_class_id: SalleDeClass.first.id}, {email: "admin@nalos.com", password: 123456, sexe: "masculin", phone: 691451189, matricule: "05I022IU", salle_de_class_id: SalleDeClass.first.id}]) if User.all.count == 0
# puts 'Student created'
#
# # default structure
# Structure.create([{name: 'root', email: 'root@nalos.com', mobile: '123456789', pays: 'Cameroun', region: 'Virtual'}])
# puts 'Structure created'
#
# # Admin User
# User.create([{name: 'NALOS', email: 'root@nalos.com', password: 123456, matricule: '007', phone1: 691451189, role_id: Role.find_by_name('admin').id, structure_id: Structure.first.id, cycle_ecole_id: CycleEcole.first.id}])
# puts 'Admin account created'
#
# # send SMS to admin user
# Sms.send(phone: User.first.phone1, msg: "Votre compte administrateur est email:#{User.first.email}, matricule: #{User.first.matricule}, mot de passe par defaut: 123456")

# seed structure type
StructureType.create([{name: "primaire"}, {name: "secondaire"}, {name: "universite"}])
