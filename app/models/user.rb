class User < ActiveRecord::Base
  has_secure_password
  validates :username, :email, :password, presence: true
  validates :password, length: { in: 6..20 }

  validates :password, confirmation: true
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/, allow_blank: true
end
