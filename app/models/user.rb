class User < ApplicationRecord
    has_many :climbs
    accepts_nested_attributes_for :climbs

    has_secure_password
    validates :username, presence: true
    validates :username, uniqueness: true
    validates :username, length: {minimum: 4}
    validates :email, presence: true
    validates :email, uniqueness: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i


end
