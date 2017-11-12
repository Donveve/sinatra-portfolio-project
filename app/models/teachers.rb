class Teacher < ActiveRecord::Base
  validates :username, uniqueness:
    { message: "username already taken"}

  has_secure_password

  has_many :students
  has_many :subjects
  has_many :instruments
end
