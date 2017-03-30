class Event < ActiveRecord::Base
	geocoded_by :location
	after_validation :geocode

	belongs_to :user
	validates :name, presence: true
	has_many :posts
end
