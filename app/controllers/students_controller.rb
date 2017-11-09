class StudentsController <  ApplicationController

  get '/students/new' do
    if session[:id]
      redirect '/show'
    else
      erb :'students/create_student'
    end
  end

  post '/students/new' do
    student = Student.create(params[:student])
    session[:id] = student.id
    # if params[:instruments]
    #   student.instruments << params[:instrument]
    # end
    #
    # if params[:subjects]
    #   student.instruments << params[:subjects]
    # end

    redirect '/students/show'
  end

  get '/students/show' do
    @student = Student.find(session[:id])

    erb :'/students/show'
  end

  get '/students/login' do
    erb :'/students/login'
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
