class StudentsController <  ApplicationController

  get '/students/new' do

    if session[:id]
      redirect '/students/show'
    else
      erb :'students/create_student'
    end
  end

  post '/students/new' do
    student = Student.create(params[:student])
    session[:id] = student.id
binding.pry
    redirect '/students/show'
  end

  get '/students/show' do
    @student = Student.find(session[:id])
    erb :'/students/show'
  end

  get '/students/login' do
    if session[:id]
      binding.pry
      redirect '/students/show'
    else
      erb :'/students/login'
    end
  end

  post '/login' do
    @student = Student.find_by(name: params[:name])
    if @student && @student.authenticate(params[:password])
      session[:id] = @student.id
      redirect '/students/show'
    else
      redirect '/students/login'
    end
  end

  get '/students/:id/edit' do
    @student = Student.find(session[:id])

    erb :'/students/edit_student'
  end

  patch '/students/:id/edit' do

    @student = Student.find(session[:id])
    @student.instruments = []
    @student.subjects = []

    if params[:instruments]
      params[:instruments].each do |t|
        @student.instruments << Instrument.find_by(name: t)
      end
    end

    if params[:subjects]
      params[:subjects].each do |t|
        @student.subjects << Subject.find_by(name: t)
      end
    end

    redirect '/students/show'
  end

  delete '/students/:id/delete' do
    binding.pry
    if session[:id] == params[:id].to_i
    @student = Student.find(params[:id])
    @student.destroy
  end
    redirect '/'
  end

  get '/logout' do
    session.clear
    redirect '/users/login'
  end

end
