class StudentsController <  ApplicationController

  get '/students/new' do
    if session[:id]
      redirect '/show'
    else
      erb :'students/create_student'
    end
  end

  post '/students/new' do
    binding.pry
    redirect '/students/show'
  end

  get '/students/login' do
    erb :'/students/login'
  end
end
