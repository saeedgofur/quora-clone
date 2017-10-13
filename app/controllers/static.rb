require "bcrypt"


get '/' do
  erb :"static/index"
end

######################

post '/sign_up' do

	@user = User.new(params[:user])
	if @user.save
		redirect '/'
	end
end




post '/log_in' do

	@user = User.find_by(email: params[:user][:email])
	 if @user && @user.authenticate(params[:user][:password])
	    session[:user_id] = @user.id
	    erb :"static/questionpage"
	 else
	    redirect '/'
	 end

end


post '/logout' do
	session[:user_id] = nil
	redirect '/'
end


######################

post '/sendto_signup' do
	erb :"static/signup"
end


post '/sendto_login' do
	erb :"static/login"
end