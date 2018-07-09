FactoryBot.define do
  # To use factories, call anyone of the 3 following methods
  # on the FactoryBot class with the name of a factory:

  # - FactoryBot.build(:job_post) <- returns the instance
  #   of a JobPost that hasn't been persisted
  # - FactoryBot.create(:job_post) <- returns the instance
  #   of a JobPost that has been persisted
  # - FactoryBot.attributes_for(:job_post) <- returns
  #   a plain ruby hash containing all parameters to create
  #   a JobPost instance. Very useful in controller testing.

  factory :job_post do
    
    # The line below will a create a user before creating
    # a job post. Then, it will assocate that user at the
    # the time of creation. The key-value arg. `factory: :user`
    # is used to choose which factory to use to create the
    # associated user.

    association(:user, factory: :user)

    sequence(:title) { |n| Faker::Job.title + " #{n}" }
    description { Faker::Hacker.say_something_smart }
    min_salary { rand(40_000..100_000) }
  end
  
end
