class TeachersController <  ApplicationController

  get '/teachers/new' do
    erb :'teachers/create_teacher'
  end

  get '/teachers/login' do
    erb :'/teachers/login'
  end

  post '/teachers/login' do
    @teacher = Teacher.find_by(name: params[:name])
    if @teacher && @teacher.authenticate(params[:password])
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

  get '/teachers/:id/edit' do
    @teacher = Teacher.find(session[:id])
    redirect :'/teachers/edit_teacher'
  end
end
