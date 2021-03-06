get '/' do
  redirect '/login'
end

## Login

get '/login' do
  if session[:user_id]
    redirect '/users'
  else
    erb :index
  end
end

post '/login' do
  @user = User.authenticate(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      redirect "/users"
    else
      redirect '/login'
    end
end

get '/logout' do
  session.clear
  redirect '/login'
end

## Create New Users

get '/users/new' do
  erb :'users/new'
end

post '/users/new' do
  # sign-up
  @user = User.new params[:user]
  if @user.save
    # successfully created new account; set up the session and redirect
    session[:user_id] = @user.id
    redirect '/users'
  else
    # an error occurred, re-render the sign-up form, displaying errors
    erb :sign_up
  end
end

## User Homepage

get '/users' do
  @user = User.find_by(id: session[:user_id])

  # @user = User.find(params[:user_id])
  # @surveys = @user.surveys
  erb :"users/show"
end


## Create Surveys

get '/surveys/name' do
  erb :'surveys/name'
end

post '/surveys/name' do
  survey = Survey.create(title: params[:title], creator: User.find_by(id: session[:user_id]))
  redirect "/surveys/#{survey.id}/new"
end

get '/surveys/:survey_id/new' do
  @survey = Survey.find_by(id: params[:survey_id])
  erb :'surveys/build_survey'
end

post '/surveys/:survey_id/add_question' do
  @survey = Survey.find_by(id: params[:survey_id])
  question = Question.create(survey: Survey.find_by(id: params[:survey_id]), question_text: params[:question_text])
  Choice.create(question: question, response: params[:answer_1])
  Choice.create(question: question, response: params[:answer_2])
  Choice.create(question: question, response: params[:answer_3])
  Choice.create(question: question, response: params[:answer_4])
  if request.xhr?
    erb :"surveys/question", layout: false
  end
end


get "/surveys/:survey_id/show" do
  @survey = Survey.find_by(id: params[:survey_id])
  erb :"surveys/show"
end

#Find user, and find survey by id
get '/surveys/:survey_id/show' do
  @survey = Survey.find(params[:survey_id])
   if session[:user_id] == params[:user_id]
    erb :"surveys/show"
  else
    redirect '/'
  end
end

get '/surveys/:survey_id/results' do
  @survey = Survey.find(params[:survey_id])
  if session[:user_id] == params[:user_id]
    erb :"surveys/results"
  else
    redirect '/'
  end
end


get '/surveys/:survey_id/respond' do
  @survey = Survey.find_by(id: params[:survey_id])
  erb :'surveys/respond'
end

get '/surveys/all' do
  @surveys = Survey.all

  erb :'surveys/all'
end


get '/surveys/:survey_id/change' do
  @user = User.find_by(id: session[:user_id])
  @survey = Survey.find_by(id: params[:survey_id])
   if session[:user_id] == params[:user_id]
    erb :"surveys/change"
  else
    redirect '/'
  end
end


post '/surveys/:survey_id/change' do
  @user = User.find_by(id: session[:user_id])
  @survey = Survey.find_by(id: params[:survey_id])
  redirect "/user/#{@user.id}/survey/#{@survey.id}"
end

post '/surveys/:survey_id/' do
  @user = User.find_by(id: session[:user_id])
  @survey = Survey.find_by(id: params[:survey_id])

end

delete '/surveys/:survey_id/' do
  @user = User.find_by(id: session[:user_id])
  @survey = Survey.find_by(id: params[:survey_id])
end

post '/surveys/:survey_id/submit' do
  param_array = params.to_a
  param_array.pop(3)
  param_array.shift(1)

  param_array.each do |pair|
    Answer.create(choice: Choice.find_by(id: pair[1]), user: User.find_by(id: session[:user_id]))
  end

  redirect '/users'
end

