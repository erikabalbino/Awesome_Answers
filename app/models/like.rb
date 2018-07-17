class Like < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :question_id, uniqueness: { scope: :user_id}

  # This validation creates a scoped uniqueness.
  # It means that can be only one of the same question_id
  # per user_id

  # id  | question_id | user_id
  #  1  | 20          | 3        <-- Valid
  #  2  | 13          | 9        <-- Valid
  #  3  | 33          | 10       <-- Valid      
  #  4  | 33          | 11       <-- Valid
  #  5  | 33          | 11       <-- Invalid
  #  6  | 20          | 3        <-- Invalid
  #  
end
