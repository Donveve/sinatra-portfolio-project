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
    @teacher = Teacher.find_by(name: params[:teacher][:name])
    if @teacher && @teacher.authenticate(params[:teacher][:password])
      session[:id] = @teacher.id
      redirect '/teachers/show'
    else
      redirect '/teachers/login'
    end
  end

  post '/teachers/new' do
    teacher = Teacher.create(params[:teacher])
    session[:id] = teacher.id
    redirect '/teachers/show'
  end

  get '/teachers/show' do
    @teacher = Teacher.find(session[:id])
    erb :'/teachers/show'
  end

  get '/teachers/edit_assignments' do
    erb:'/teachers/edit_assignments'
  end

  patch '/teachers/edit_assignments' do
    binding.pry
    Instruments = []
    Subjects = []
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
