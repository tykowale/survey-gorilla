require 'faker'

10.times do
  User.create(name: Faker::Name.name)
end

2.times do
  Survey.create(title: Faker::Company.name, creator: User.first)
end

10.times do
  Question.create(question_text: "Question", survey: Survey.all.sample)
end

40.times do
  Choice.create(response: ['a','b','c','d'].sample, question: Question.all.sample)
end

Choice.all.each do |choice|
  Answer.create(choice: choice, participant: User.all.sample)
end
