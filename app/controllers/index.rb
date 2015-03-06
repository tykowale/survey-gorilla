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
      redirect "/users/#{@user.id}/"
    else
      redirect '/login'
    end
end

get '/user/new' do
  erb :"users/new"
end

post '/user/new' do
  redirect '/user/:user_id'
end

get '/user/:user_id' do
  @user = User.find(params[:user_id])
  @surveys = @user.surveys
  erb :index
end

