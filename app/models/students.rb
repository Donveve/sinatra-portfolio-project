class Student < ActiveRecord::Base
    has_secure_password
    validates :username, uniqueness: true
    #{ message: "already taken"}

  has_many :instruments
  has_many :subjects
  belongs_to :teacher
end
