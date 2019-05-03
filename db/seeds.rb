# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

workspaces = Workspace.create([
  { label: "Private", description: Faker::Lorem.sentences, context: Faker::Lorem.words, public: false },
  { label: "Personal", description: Faker::Lorem.sentences, context: Faker::Lorem.words, public: true }
])

projects = Project.create([
  { title: Faker::Lorem.sentence, description: Faker::Lorem.sentences, workspace_id: workspaces.first.id },
  { title: Faker::Lorem.sentence, description: Faker::Lorem.sentences, workspace_id: workspaces.last.id }
])

Task.create([
  { title: Faker::Lorem.sentence, content: Faker::Lorem.sentences, state: "TODO", project_id: projects.first.id },
  { title: Faker::Lorem.sentence, content: Faker::Lorem.sentences, state: "TODO", project_id: projects.first.id },
  { title: Faker::Lorem.sentence, content: Faker::Lorem.sentences, state: "TODO", project_id: projects.last.id },
  { title: Faker::Lorem.sentence, content: Faker::Lorem.sentences, state: "TODO", project_id: projects.last.id }
])
