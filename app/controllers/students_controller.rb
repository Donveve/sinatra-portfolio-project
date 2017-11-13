
class StudentsController <  ApplicationController

  get '/students/new' do
    if session[:id]
      session.clear
    end
      erb :'students/create_student'
  end

  post '/students/new' do
    @student = Student.new(params[:student])
    if @student.save
      session[:id] = @student.id
      redirect '/students/show'
    else

      erb :'students/create_student'
    end
  end

  get '/students/show' do
    @student = Student.find(session[:id])
    erb :'/students/show'
  end

  get '/students/login' do
    if session[:id]
      session.clear
    end
      session[:failure_message] = "That log in wasn't quite right. Please try again."
      erb :'/students/login'
  end

  post '/students/login' do
    @student = Student.find_by(username: params[:student][:username])
    if @student && @student.authenticate(params[:student][:password])
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

  get '/students/:id/delete' do
    if session[:id] == params[:id].to_i
    @student = Student.find(params[:id])
  end
    erb :'/students/delete'
  end

  delete '/students/:id/delete' do
    if session[:id] == params[:id].to_i
    @student = Student.find(params[:id])
    @student.destroy
    session.clear
  end
    redirect '/'
  end

  get '/students/logout' do
    session.clear
    redirect '/'
  end

end
