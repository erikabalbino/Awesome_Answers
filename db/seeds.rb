# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PASSWORD = "supersecret"

Answer.delete_all
Question.delete_all
User.delete_all

super_user = User.create(
  first_name: "Jon",
  last_name: "Snow",
  email: "js@winterfell.gov",
  password: PASSWORD
)

10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD
  )
end

users = User.all

puts Cowsay.say "Created #{users.count} users", :tux

100.times do
  q = Question.create(
    title: Faker::Hacker.say_something_smart,
    body: Faker::HarryPotter.quote,
    view_count: rand(0...9999),
    user: users.sample
  )

  if q.valid?
    rand(0..10).times do
      Answer.create(
        body: Faker::Matz.quote,
        question: q,
        user: users.sample
      )
    end
  end
end

questions = Question.all
answers = Answer.all

puts Cowsay.say("Created #{questions.count} questions", :frogs)
puts Cowsay.say("Created #{answers.count} answers", :sheep)
puts "Login with #{super_user.email} and password of #{PASSWORD}"
