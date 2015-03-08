get '/' do
  redirect '/login'
end

## Login

get '/login' do
  erb :index
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
  survey = Survey.create(title: params[:title])
  redirect "/surveys/#{survey.id}/new"
end

get '/surveys/:survey_id/new' do
  @survey = Survey.find_by(id: params[:survey_id])
  erb :'surveys/build_survey'
end

post '/surveys/:survey_id/add_question' do
  question = Question.create(survey: Survey.find_by(id: params[:survey_id]), question_text: params[:question_text])
  Choice.create(question: question, response: params[:answer_1])
  Choice.create(question: question, response: params[:answer_2])
  Choice.create(question: question, response: params[:answer_3])
  Choice.create(question: question, response: params[:answer_4])
  if request.xhr?
    erb :"surveys/question"
  end
end

post "/surveys/:survey_id/save" do
  @survey = Survey.find_by(params[id: :survey_id])
## Need to save last question on the page!
  redirect "/surveys/#{@survey.id}/show"
end

get "/surveys/:survey_id/show" do
  @survey = Survey.find_by(params[id: :survey_id])
  erb :"surveys/show"
end

#Find user, and find survey by id
get '/survey/:survey_id/show' do
  @survey = Survey.find(params[:survey_id])
   if session[:user_id] == params[:user_id]
    erb :"surveys/show"
  else
    redirect '/'
  end
end

get '/survey/:survey_id/results' do
  @survey = Survey.find(params[:survey_id])
  if session[:user_id] == params[:user_id]
    erb :"surveys/results"
  else
    redirect '/'
  end
end


get '/survey/:survey_id/respond' do
  @survey = Survey.find(params[:'/survey_id'])
  erb :'surveys/respond'
end

get '/surveys/all' do
  @surveys = Survey.all

  erb :'surveys/all'
end


get '/survey/:survey_id/change' do
  @user = User.find_by(session[:user_id])
  @survey = Survey.find(params[:survey_id])
   if session[:user_id] == params[:user_id]
    erb :"surveys/change"
  else
    redirect '/'
  end
end


post '/survey/:survey_id/change' do
  @user = User.find_by(session[:user_id])
  @survey = Survey.find(params[:survey_id])
  redirect "/user/#{@user.id}/survey/#{@survey.id}"
end

post '/survey/:survey_id/' do
  @user = User.find_by(session[:user_id])
  @survey = Survey.find(params[:survey_id])

end

delete '/survey/:survey_id/' do
  @user = User.find_by(session[:user_id])
  @survey = Survey.find(params[:survey_id])
end




