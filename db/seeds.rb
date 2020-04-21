# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
CourseStatus.create([{ name: 'waiting' }, { name: 'validate' }, { name: 'rejected' }]) if CourseStatus.all.count == 0

# role user
Role.create!([{ name: "teacher" }, { name: "admin" }, { name: "ap" }, { name: "administration" }])

# adding cycle ecole
CycleEcole.create([{ name: "Francophone", code: "Fr", structure_id: 1 }, { name: "Englophone", code: "En", structure_id: 1 }]) if CycleEcole.all.count == 0

# Automatisation des matieres
Matiere.create([{ name: "Francais" }, { name: "English" }, { name: "Mathématique" }, { name: "Histoire" }, { name: "Géographie" }]) if Matiere.all.count == 0

# automatisation des salle de classe
SalleDeClass.create([{ name: "Premiere D1", cycle_ecole_id: 1 }, { name: "Premiere D2", cycle_ecole_id: 1 }, { name: "Premiere C", cycle_ecole_id: 1 }])

# auto create Student
Student.create([{email: "student@m.com", password: 123456, sexe: "masculin", phone: 691451189, matricule: "05I022IU", salle_de_class_id: 1}, {email: "admin@m.com", password: 123456, sexe: "masculin", phone: 691451189, matricule: "05I022IU", salle_de_class_id: 1}]) if User.all.count == 0
