class Post < ActiveRecord::Base

  validates :body, presence: true
  validates :title, presence: true, length: { maximum: 500 }

end
