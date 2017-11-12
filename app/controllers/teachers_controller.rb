class TeachersController <  ApplicationController

  get '/teachers/new' do
    if session[:id]
      session.clear
    end
      erb :'teachers/create_teacher'
  end

  get '/teachers/login' do
    if session[:id]
      session.clear
    end
      erb :'/teachers/login'
  end

  post '/teachers/login' do

    @teacher = Teacher.find_by(username: params[:teacher][:username])
    if @teacher && @teacher.authenticate(params[:teacher][:password])
      session[:id] = @teacher.id
      redirect '/teachers/show'
    else
      redirect '/teachers/login'
    end
  end

  post '/teachers/new' do
    teacher = Teacher.new(params[:teacher])
    if teacher.save
      session[:id] = teacher.id
      redirect '/teachers/show'
    else
      erb :'teachers/create_teacher'
    end
  end

  get '/teachers/show' do
    @teacher = Teacher.find(session[:id])
    erb :'/teachers/show'
  end

  get '/teachers/edit_assignments' do
    erb:'/teachers/edit_assignments'
  end

  patch '/teachers/edit_assignments' do
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
  end

  get '/teachers/display_assignments' do
    erb :'/teachers/display_assignments'
  end

  get '/teachers/:id/edit' do
    @teacher = Teacher.find(session[:id])
    erb :'/teachers/edit_teacher'
  end

  patch '/teachers/:id/edit' do

    @teacher = Teacher.find(session[:id])
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
  end

  get '/teachers/:id/show_student' do
    @student = Student.find(params[:id])
    @teacher = Teacher.find(session[:id])
    erb :'/teachers/show_student'
  end

  get '/teachers/:id/delete' do
    if session[:id] == params[:id].to_i
    @teacher = Teacher.find(params[:id])
    end
    erb :'/teachers/delete'
  end

  delete '/teachers/:id/delete' do
    if session[:id] == params[:id].to_i
    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    session.clear
    end
    redirect '/'
  end

  get '/teachers/logout' do
    session.clear
    redirect '/'
  end

end
