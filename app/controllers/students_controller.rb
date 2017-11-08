class StudentsController <  ApplicationController

  get '/students/new' do
    erb :'students/create_student'
  end

  get '/students/login' do
    erb :'/students/login'
  end
end
