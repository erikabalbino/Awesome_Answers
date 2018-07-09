require 'rails_helper'

RSpec.describe JobPost, type: :model do
  # We use `describe` to group a collection of tests
  # together. It's primarily used to organize our tests
  # and introduce a new scope with the block.
  # This describe should group only tests related
  # to the validations of our JobPost model.

  describe 'validation' do

    it 'requires a title' do # def test_requires_a_title
      # Given: a instance of a JobPost
      jp = FactoryBot.build(:job_post, title: nil)

      # When: Validations are triggered
      jp.valid?

      # Then: There's a title related error in the instance
      expect(jp.errors.messages).to(have_key(:title))
    end

    it 'requires a unique title' do
        # Given: one job post in the db and an instance
        # of job post with the same title

        persisted_jp = FactoryBot.create(:job_post)

        jp = FactoryBot.build(
          :job_post,
          title: persisted_jp.title
        )

        # Given: Trigger validations
        jp.valid?

        # Then: We get an error on the title
        expect(jp.errors.messages).to(have_key(:title))
        expect(jp.errors.messages[:title]).to(include("has already been taken"))

    end

    it "requires a min salary greater than 40_000" do
      jp = FactoryBot.build(:job_post, min_salary: 39_999)

      jp.valid?

      expect(jp.errors.messages).to have_key(:min_salary)
      
    end
    

  end

  describe '.search' do

    # Use `before` to run some before all tests within the
    # block of a `describe` or `context`.

    # The `before` call below will create three JobPost
    # before running any tests inside this `describe` block.
    before do
      # Given: JobPosts in my db
      @jp_1 = FactoryBot.create(
        :job_post,
        title: "Imagination Engineer",
        description: "Think and create things"
      )
      @jp_2 = FactoryBot.create(
        :job_post,
        title: "Fire Specialist",
        description: "Burn and un-burn things"
      )
      @jp_3 = FactoryBot.create(
        :job_post,
        title: "Software Athlete",
        description: "You tell me?!"
      )
      @jp_4 = FactoryBot.create(
        :job_post,
        title: "Thinkanator",
        description: "Skilled at an aggressive meditation technique"
      )
    end

    it 'finds by text contained in title' do
      # When: We search for "ware"
      jps = JobPost.search("ware")

      # Then: Returns last jp in a collection
      expect(jps.count).to(be(1))
      expect(jps.first).to(eq(@jp_3))
    end

    it 'finds by text contained in description' do
      # When: We search for "burn"
      jps = JobPost.search("burn")

      # Then: Returns last jp in collection
      expect(jps.count).to be 1
      expect(jps.first).to(eq(@jp_2))

    end

    it "find text contained in description and title" do
      jps = JobPost.search("think")

      expect(jps.count).to be 2
      expect(jps).to eq [@jp_1, @jp_4]
    end

  end

end
