get '/' do
  # render home page
 #TODO: Show all users if user is signed in
 @user = User.find_by_id(session[:user_id]) if session[:user_id]
  if @user
  	@all_user_names = User.pluck(:name)
  	p @all_user_names
    erb :index
  else
  	redirect 'sessions/new'
  end
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page 
  erb :sign_in
end

post '/sessions' do
  # sign-in
  user = User.find_by_email([params[:email]])
  if user.password == params[:password]
  	session[:user_id] = user.id
  	redirect '/'
  else
  	redirect '/'
  end
end

delete '/sessions/:id' do
	puts "hi"
	session[:user_id] = nil
  # sign-out -- invoked via AJAX
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page  
  @error_message = "Email already exists" if params[:msg] == "email_exists"

  erb :sign_up
end

post '/users' do
	unless User.find_by_email(params[:email])
		user = User.new(name: params[:name], email: params[:email])
		user.password = params[:password]
		user.save

		redirect "/sessions/new"
	else
    redirect "/users/new?msg=email_exists"
  end
end
