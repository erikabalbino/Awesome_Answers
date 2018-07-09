class JobPost < ApplicationRecord
    belongs_to :user

    validates :title, presence: true, uniqueness: true
    validates :min_salary, numericality: {greater_than: 40_000}

    def self.search(query)
        # where("title ILIKE ? OR description ILIKE ?",
        #      "%#{query}%",
        #      "%#{query}%"
        #      )
        where("title ILIKE ?", "%#{query}%") 
            .or(where("description ILIKE ?", "%#{query}%"))
    end
    
end
