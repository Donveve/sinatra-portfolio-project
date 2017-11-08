class Student < ActiveRecord::Base
  has_many :instruments
  has_many :subjects
  belongs_to :teacher
end
