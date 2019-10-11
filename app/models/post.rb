class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction),
    message: "%{value} is not a valid category. Please choose 'Fiction' or 'Non-Fiction.'" }
  validate :sufficiently_clickbaity

  private

    def includes_clickbait?
      if !self.title.nil?
        return self.title.include?("Won't Believe") ||
          self.title.include?("Secret") ||
          self.title.include?("Top") ||
          self.title.include?("Guess")
      else  
        return false
      end
    end

    def sufficiently_clickbaity
      unless includes_clickbait?
        errors.add(:title, "is not clickbait-y enough")
      end
    end
end
