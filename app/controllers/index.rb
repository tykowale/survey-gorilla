# This is our homepage
get '/' do
  if session[:user_id]
    redirect "/users/#{session[:user_id]}/"
  else
    redirect '/login'
  end
end

get '/login' do
  erb :index
end
#---------------------------------



# User authentication, checking to see if user exists, if yes, create session
post '/login' do
  @user = User.authenticate(params[:email], params[:password])
  if @user
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}/"
  else
    redirect '/login'
  end
end
#---------------------------------



# Get new user form
get '/user/new' do
  erb :"users/new"
end

# Takes info from new user, if information valid, create a new user, and redirect to profile, otherwise go to login page.
post '/user/new' do
  @user = User.create(name: params[:name], email: params[:email], password: params[:password])
  if @user.valid?
    session[:user_id] = @user.id
    redirect "/user/#{@user.id}/"
  else
    @errors = @user.errors
    redirect '/login'
  end
end
#---------------------------------


#Find user, and get surveys for user
get '/user/:user_id' do
  if session[:user_id] == params[:user_id]
    @user = User.find(params[:user_id])
    erb :"users/show"
  else
    redirect '/'
  end
end
#---------------------------------



#Find user, and find survey by id
get '/user/:user_id/survey/:survey_id/show' do
  @survey = Survey.find(params[:survey_id])
   if session[:user_id] == params[:user_id]
    erb :"surveys/show"
  else
    redirect '/'
  end
end

get '/user/:user_id/survey/:survey_id/results' do
  @survey = Survey.find(params[:survey_id])
  if session[:user_id] == params[:user_id]
    erb :"surveys/results"
  else
    redirect '/'
  end
end


get '/user/:user_id/survey/:survey_id/respond' do
  @survey = Survey.find(params[:'/survey_id'])
  erb :'surveys/respond'
end

get '/surveys/all' do
  @surveys = Survey.all

  erb :'surveys/all'
end

get '/user/:user_id/survey/new' do
  @user = User.find(params[:user_id])
   if session[:user_id] == params[:user_id]
    erb :"surveys/change"
  else
    redirect '/'
  end
end

get '/user/:user_id/survey/:survey_id/change' do
  @user = User.find(params[:user_id])
  @survey = Survey.find(params[:survey_id])
   if session[:user_id] == params[:user_id]
    erb :"surveys/change"
  else
    redirect '/'
  end
end


post '/user/:user_id/survey/:survey_id/change' do
  @user = User.find(params[:user_id])
  @survey = Survey.find(params[:survey_id])
  redirect "/user/#{@user.id}/survey/#{@survey.id}"
end

post '/user/:user_id/survey/:survey_id/' do
  @user = User.find(params[:user_id])
  @survey = Survey.find(params[:survey_id])

end

delete '/user/:user_id/survey/:survey_id/' do
  @user = User.find(params[:user_id])
  @survey = Survey.find(params[:survey_id])
end



