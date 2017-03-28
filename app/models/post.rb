class Post < ActiveRecord::Base
	validates :anchor_text, :comment, presence: true
	belongs_to :event
end
