class Student < ActiveRecord::Base
    has_secure_password
    validates :username, uniqueness:{ message: "username already taken"}

  has_many :instruments
  has_many :subjects
  belongs_to :teacher
end
