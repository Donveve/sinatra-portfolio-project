
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
      session[:student_id] = @student.id
  
      redirect '/students/show'
    else
      session[:failure_message] = @student.errors.full_messages.to_sentence
      erb :'students/create_student'
    end
  end

  get '/students/show' do
    @student = current_student
    if @student !=nil
      erb :'/students/show'
    else
      session[:need_to_login] = "You need to log in to view this page"
      erb :index
    end
  end

  get '/students/login' do
    if session
      session.clear
    end
      erb :'/students/login'
  end

  post '/students/login' do
    @student = Student.find_by(username: params[:student][:username])
    if @student && @student.authenticate(params[:student][:password])
      session[:student_id] = @student.id
      redirect '/students/show'
    else
      session[:failure_message] = "That log in wasn't quite right. Please try again."
      redirect '/students/login'
    end
  end

  get '/students/:id/edit' do
    if is_student_logged_in?
      @student = current_student
      erb :'/students/edit_student'
    else
      session[:need_to_login] = "You need to log in to view this page"
      redirect "/students/login"
    end
  end

  patch '/students/:id/edit' do
    if is_student_logged_in?
      @student = current_student
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
      erb :'/students/show'
    else
      session[:need_to_login] = "You need to log in to view this page"
      redirect "/teachers/login"
    end
  end

  get '/students/:id/delete' do
    if is_student_logged_in?
      if session[:student_id] == params[:id].to_i
        @student = current_student
      end
      erb :'/students/delete'
    else
      erb :index
    end
  end

  delete '/students/:id/delete' do
    if is_student_logged_in? && session[:student_id] == params[:id].to_i
        @student = current_student
        @student.destroy
        session.clear
        redirect '/'
    else
      session[:need_to_login] = "You need to log in to view this page"
      redirect "/teachers/login"
    end
  end

  get '/students/logout' do
    if is_student_logged_in?
      session.clear
      redirect '/'
    else
      session[:need_to_login] = "You need to log in to view this page"
      redirect "/students/login"
    end
  end
end
