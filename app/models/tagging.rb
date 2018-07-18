class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :question

  validates :question_id, uniqueness: { scope: :tag_id}
  
end
