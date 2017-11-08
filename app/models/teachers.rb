class Teacher < ActiveRecord::Base
  has_secure_password
  
  has_many :students
  has_many :subjects
  has_many :instruments
end
