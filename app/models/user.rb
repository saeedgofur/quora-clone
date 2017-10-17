class User < ActiveRecord::Base
	has_secure_password

	has_many :questions
	has_many :answers
	validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
	validates :username, uniqueness: true
end