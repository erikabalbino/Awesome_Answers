class Question < ApplicationRecord
  # `validates` is a method provided by
  # the parent class `ApplicationRecord` that
  # can be used to enforce rules on the data
  # that is saved in our database.

  # - The first arguments(s) are column names
  # - The last arguments are key->value arguments
  #   describing the rules to enforce

  validates(:title, presence: true, uniqueness: true)

  # - presence rule means that the title must exist
  # - uniqueness rule means that all questions must have
  #   different titles

  # When a model fails a validation, you can check
  # the errors by using the .errors method.
  # For more readable error messages, use .errors.full_messages.

  validates(
    :body,
    presence: {
      message: "must be given" # provide custom validation error message
    },
    length: {
      minimum: 10,
      maximum: 2048
    }
  )

  validates(
    :view_count,
    numericality: {
      greater_than_or_equal_to: 0
    }
  )

    # We can create custom validations. Use the `validate`
    # method instead of `validates`. `validate` takes symbol
    # that correspond to a method name.

  validate :no_monkey

  before_validation :set_default_view_count

  private
  def set_default_view_count
    # self.view_count = 0 unless view_count.present?
    # self.view_count = self.view_count || 0
    # puts "🤷‍♀️¸ Setting sefault view_count"
    self.view_count ||= 0
  end

  def no_monkey

    # &. is the safe navigation operator.
    # Use it instead of `.` when chaining methods.
    # If the value before `&.` is `nil`, then
    # `nil` will be returned instead of raising
    # an error like "undefined method for nil:NilClass"

    if body&.downcase&.include?("monkey")
      errors.add(:body, "must not have a monkey")
    end

  end

end
