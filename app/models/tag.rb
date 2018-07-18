class Tag < ApplicationRecord

    validates :name, presence: true, uniqueness: true

    before_validation :downcase_name
  
    has_many :taggings, dependent: :destroy
    has_many :questions, through: :taggings
  
    def humanized_name
        name&.humanize
    end 

    private
    def downcase_name
      self.name&.downcase!
    end

end
