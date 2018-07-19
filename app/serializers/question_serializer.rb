class QuestionSerializer < ActiveModel::Serializer
  # ActiveModel::Serializer Docs:
  # https://github.com/rails-api/active_model_serializers/blob/v0.10.6/docs/README.md

  # Use the `attributes` method to specify which methods
  # of a model to including the serialization output.
  # All columns of a model have a corresponding therefore
  # we can filter this way as well.
  attributes(
    :id,
    :title,
    :body,
    :created_at,
    :updated_at,
    :like_count,
    :view_count
  )

  # To include associated models, use the same named
  # methods used for creating associations. You can rename
  # the association with "key" which is only going to show
  # in the rendered "json".
  belongs_to(:user, key: :author)
  has_many(:answers)

  # To customize serialize for associated models, you
  # can a define serializer within the current
  # serializer.
  class AnswerSerializer < ActiveModel::Serializer
    # This will be used to serialize the answers
    # from `has_many(:answers)`
    attributes :id, :body, :created_at, :updated_at

    belongs_to(:user, key: :author)
  end

  # You can create methods inside serializer to include
  # custom data in the "json" serialization. When doing
  # so, make sure to include the name of the method
  # the `attributes` call.
  def like_count
    # `object` will refer to the instance of the model
    # being serialized. Use it where you would use `self` in
    # the model class.
    object.likes.count
  end

end
