class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :answer

  # Be careful when using the presence, because the check is
  # naive. It only verifies the truthiness of the field meaning
  # that `false` and `nil` count as being blank (not present).
  validates :up, inclusion: { in: [true, false], message: "must be true or false"}  #presence: :true

  # When validation booleans, use the `inclusion` validation. It
  # verifies that a column must one of a set of values specified
  # in an array. In our validation above, the value must be `true`
  # or `false`. `nil` will not be accepted.

  validates :user_id, uniqueness: { scope: :answer_id}

  def down?
    !up?
  end
end
