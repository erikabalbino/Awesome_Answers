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
      jp = JobPost.new

      # When: Validations are triggered
      jp.valid?

      # Then: There's a title related error in the instance
      expect(jp.errors.messages).to(have_key(:title))
    end

    it 'requires a unique title' do
        # Given: one job post in the db and an instance
        # of job post with the same title

        persisted_jp = JobPost.create(
          title: "Imagination Engineer"
        )
        jp = JobPost.new title: persisted_jp.title

        # Given: Trigger validations
        jp.valid?

        # Then: We get an error on the title
        expect(jp.errors.messages).to(have_key(:title))
        expect(jp.errors.messages[:title]).to(include("has already been taken"))

    end

  end

  describe '.search' do
    it 'returns the correct job post' do
      # Given: JobPosts in my db
      jp_1 = JobPost.create(
        title: "Imagination Engineer",
        description: "Think and create things"
      )
      jp_2 = JobPost.create(
        title: "Fire Specialist",
        description: "Burn and un-burn things"
      )
      jp_3 = JobPost.create(
        title: "Software Athlete",
        description: "You tell me?!"
      )

      # When: We search for "ware"
      jps = JobPost.search("ware")

      # Then: Returns last jp in a collection
      expect(jps.count).to(be(1))
      expect(jps.first).to(eq(jp_3))
    end
  end

end
