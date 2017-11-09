
student = [
  [ "Abigail", 6 ],
  [ "Annabella", 5 ],
  [ "Alexander", 3 ],
  [ "Austin", 1 ]
]

student.each do |name, grade|
  Student.create( name: name, grade: grade )
end

Teacher.create(name: "Melissa")

subject_list = [
  [ "History" ],
  [ "Math" ],
  [ "History" ],
  [ "Spanish" ],
  [ "Latin" ],
  [ "Music" ],
  [ "Science" ],
  [ "Reading" ]
]

subject_list.each do |name|
  Subject.create( name: name )
end

instruments = [
  [ "Piano" ],
  [ "Violin" ],
  [ "Guitar" ],
  [ "Harmonica" ],
]

instruments.each do |name|
  Instrument.create( name: name )
end
