require "httparty"

# nice output in console YAML::ENGINE.yamler = 'syck'


class UsersController < ApplicationController

	def index

	end

	def show
		@user = User.find(params[:id])

		@my_answers = HTTParty.get(api_answers_url(@user.ame_user_id, @user.question_id),
						:query => {:access_token => access_token}
			).parsed_response

	end

	def create
		ame_user = HTTParty.post(api_users_url,
					:query => {:access_token => access_token},
		      :body => { :email => params[:email] }.to_json,
		    	:headers => { 'Content-Type' => 'application/json' } 
    	).parsed_response

		if !ame_user or ame_user['error']
			flash[:alert] = "Uh oh... that email isn't working. please enter a valid email."
      redirect_to :root and return
		end

		# check if user is already in db
		@user = User.find_by_email(ame_user['email'])
		if @user
			# log in
			session[:user_id] = @user.id
			flash[:notice] = "Welcome back!"
			redirect_to user_url(@user) and return
		end

		# if not, create new user
		@user = User.new(email: ame_user['email'], ame_user_id: ame_user['id'], pw_token: ame_user['pw_token'])

		if @user and @user.save
			session[:user_id] = @user.id

			# set the question - defaults to email at 9am CST
			ame_question = HTTParty.post(api_questions_url(@user.ame_user_id),
							:query => {:access_token => access_token},
							:body => { :question => 'Rejection Therapy for today?'}.to_json,
				    	:headers => { 'Content-Type' => 'application/json' } 
				).parsed_response

			@user.question_id = ame_question['id']
			@user.save

			flash[:notice] = "Woohoo! Thanks for signing up. Every day, you'll be emailed 
					'Rejection Therapy for today?' at 9am. 
					Just reply and your rejection story will be recorded below."
      redirect_to user_url(@user)
    else
      flash[:alert] = "Failed to create a new user"
      redirect_to :root
    end
		
	end

	def profile
		@user = User.find(params[:id])
		@ame_url = 'http://askmeevery.com/users/'+@user.ame_user_id.to_s+'/questions'
	end

	def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out."
    redirect_to :root
  end



	private 

		# For Testing
		# AME_API_BASE = "http://4ja9.localtunnel.com/api/v1"

		# For Prod
		AME_API_BASE = "http://askmeevery.com/api/v1"

		def access_token
			# 'c8cbacf71b319bf590422fd817553f15' # for testing
			'bb7aafd9a1a2cf8e21fb1632991aab77' # for production
		end

		def api_users_url
			"#{AME_API_BASE}/users.json"
		end
		def api_user_url(id)
			"#{AME_API_BASE}/users/#{id}.json"
		end
		def api_questions_url(id)
			"#{AME_API_BASE}/users/#{id}/questions.json"
		end
		def api_schedule_url(id, question_id)
			"#{AME_API_BASE}/users/#{id}/questions/#{question_id}.json"
		end
		def api_answers_url(id, question_id)
			"#{AME_API_BASE}/users/#{id}/questions/#{question_id}/answers.json"
		end

end