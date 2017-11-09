class TeachersController <  ApplicationController

  get '/teachers/new' do
    erb :'teachers/create_teacher'
  end

  get '/teachers/login' do
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

  get '/teachers/:id/edit' do
    @teacher = Teacher.find(session[:id])
    erb :'/teachers/edit_teacher'
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
    redirect '/teachers/login'
  end
end
