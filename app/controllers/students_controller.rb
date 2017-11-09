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
    @sstudent = Student.find(session[:id])
    erb :'/students/edit_student'
  end

  post '/students/:id/edit' do

    redirect '/students/show'
  end


end
