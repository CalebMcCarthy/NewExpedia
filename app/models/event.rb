class Event < ActiveRecord::Base

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

	geocoded_by :location
	after_validation :geocode

	belongs_to :user
	validates :name, presence: true
	has_many :posts
end
