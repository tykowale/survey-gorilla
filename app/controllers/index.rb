get '/' do
  redirect '/login'
end

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


get '/users' do
  @user = User.find_by(id: session[:user_id])
  # @user = User.find(params[:user_id])
  # @surveys = @user.surveys
  erb :"users/show"
end

# get '/surveys/:id/new' do



#   erb :'surveys/new'
# end

# post '/user/' do

# end

