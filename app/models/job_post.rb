class JobPost < ApplicationRecord
    validates :title, presence: true, uniqueness: true

    def self.search(query)
        where("title ILIKE ?", "%#{query}%")
    end
    
end
