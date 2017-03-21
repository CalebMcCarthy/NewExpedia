class Post < ActiveRecord::Base
	validates :anchor_text, :comment, presence: true
end
