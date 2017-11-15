class TeachersController <  ApplicationController
  include Helpers

  get '/teachers/new' do
    if session[:teacher_id]
      session.clear
    end
      erb :'teachers/create_teacher'
  end

  get '/teachers/login' do
    if session[:teacher_id]
      session.clear
    end
      erb :'/teachers/login'
  end

  post '/teachers/login' do
    @teacher = Teacher.find_by(username: params[:teacher][:username])
    if @teacher && @teacher.authenticate(params[:teacher][:password])
      session[:teacher_id] = @teacher.id
      redirect '/teachers/show'
    else
      session[:failure_message] = "That log in wasn't quite right. Please try again."
      redirect '/teachers/login'
    end
  end

  post '/teachers/new' do
    @teacher = Teacher.new(params[:teacher])
    if @teacher.save
      session[:teacher_id] = @teacher.id
      redirect '/teachers/show'
    else
      @teacher.errors.full_messages.to_sentence
      erb :'teachers/create_teacher'
    end
  end

  get '/teachers/show' do
    @teacher = current_teacher
    if @teacher != nil
        erb :'/teachers/show'
    else
      session[:need_to_login] = "You need to log in to view this page"
      erb :index
    end
  end

  get '/teachers/edit_assignments' do
    if is_teacher_logged_in?
      erb:'/teachers/edit_assignments'
    else
      session[:need_to_login] = "You need to log in to view this page"
      redirect "/teachers/login"
    end
  end

  patch '/teachers/edit_assignments' do
    if  is_teacher_logged_in?
      params[:new_subject].each do |s|
        if !s.empty?
            Subject.create(name: s )
        end
      end

      params[:new_instrument].each do |i|
        if !i.empty?
            Instrument.create(name: i)
        end
      end

      if params[:subjects]
        params[:subjects].each do |t|
          Subject.find_by(name: t).destroy
        end
      end

      if params[:instruments]
        params[:instruments].each do |t|
          Instrument.find_by(name: t).destroy
        end
      end
      redirect '/teachers/display_assignments'
    else
      session[:need_to_login] = "You need to log in to view this page"
      redirect "/teachers/login"
    end
  end

  get '/teachers/display_assignments' do
    if  is_teacher_logged_in?
      erb :'/teachers/display_assignments'
    else
      session[:need_to_login] = "You need to log in to view this page"
      redirect "/teachers/login"
    end
  end

  get '/teachers/:id/edit' do
    if  is_teacher_logged_in?
      @teacher = current_teacher
      erb :'/teachers/edit_teacher'
    else
      session[:need_to_login] = "You need to log in to view this page"
      redirect "/teachers/login"
    end
  end

  patch '/teachers/:id/edit' do
    if  is_teacher_logged_in?
      @teacher = current_teacher
      @teacher.students = []
      if params[:students]
        params[:students].each do |t|
          @teacher.students << Student.find_by(name: t)
        end
      end

      if params[:students_new]
        params[:students_new].each do |t|
          @teacher.students << Student.find_by(name: t)
        end
      end
      erb :'/teachers/show'
    else
      session[:need_to_login] = "You need to log in to view this page"
      redirect "/teachers/login"
    end
  end

  get '/teachers/:id/show_student' do
    if  is_teacher_logged_in?
      @student = Student.find_by(id: params[:student_id])
      @teacher = current_teacher
      erb :'/teachers/show_student'
    else
      session[:need_to_login] = "You need to log in to view this page"
      redirect "/teachers/login"
    end
  end

  get '/teachers/:id/delete' do
    if  is_teacher_logged_in?
      if session[:teacher_id] == params[:id].to_i
        @teacher = current_teacher
      end
      erb :'/teachers/delete'
    else
      erb :index
    end
  end

  delete '/teachers/:id/delete' do
    if is_teacher_logged_in?
      if session[:teacher_id] == params[:id].to_i
        @teacher = current_teacher
        @teacher.destroy
        session.clear
      end
        redirect '/'
    else
      session[:need_to_login] = "You need to log in to view this page"
      redirect "/teachers/login"
    end
  end

  get '/teachers/logout' do
    if is_teacher_logged_in?
      session.clear
      redirect '/'
    else
      session[:need_to_login] = "You need to log in to view this page"
      redirect "/teachers/login"
    end
  end

end
