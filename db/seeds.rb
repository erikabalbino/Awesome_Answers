# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Answer.delete_all
Question.delete_all

100.times do
  q = Question.create(
    title: Faker::Hacker.say_something_smart,
    body: Faker::HarryPotter.quote,
    view_count: rand(0...9999)
  )

  if q.valid?
    rand(0..10).times do
      Answer.create(
        body: Faker::Matz.quote,
        question: q
      )
    end
  end
end

questions = Question.all
answers = Answer.all

puts Cowsay.say("Created #{questions.count} questions", :frogs)
puts Cowsay.say("Created #{answers.count} answers", :sheep)
