require "bcrypt"


get '/' do
  erb :"static/index"
end

get '/newsfeed' do
	erb :"static/newsfeed"
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
	    erb :"static/create_questionpage"
	 else
	    redirect '/'
	 end

end


get '/logout' do
	session[:user_id] = nil
	redirect '/'
end


######################

get '/sendto_signup' do
	erb :"static/signup"
end


get '/sendto_login' do
	erb :"static/login"
end

get '/sendto_create_question' do

	if session[:user_id] == nil
		redirect '/'
	else
		erb :"static/create_questionpage"
	end

end

######################

get '/questions/:id' do

	erb :'static/questionprofile'

end

######################

get '/questions/:id/sendto_answer' do

	erb :'static/create_answerpage'

end

######################

post '/create_questions' do

	@question = current_user.questions.new(question_description: params[:new_question])
	@question.save

	redirect '/newsfeed'

end

post '/questions/:id/answer' do
	@answer = Answer.new(question_id: params[:id], answer_description: params[:new_answer], user_id: current_user.id)
	@answer.save

	redirect '/newsfeed'
end

######################

get '/user' do

	if session[:user_id] == nil
		redirect '/'
	else
		erb :"static/profilepage"
	end

end