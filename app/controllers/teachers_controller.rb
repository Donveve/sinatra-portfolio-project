class TeachersController <  ApplicationController

  get '/teachers/new' do
    erb :'teachers/create_teacher'
  end

  get '/teachers/login' do
    erb :'/teachers/login'
  end

end
