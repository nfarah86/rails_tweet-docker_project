class JsonHandlerController < ApplicationController
	#respond_to :json
	 skip_before_filter :verify_authenticity_token  


	def create
		r = JSON.parse(request.raw_post)
		if r['text']
			message = Message.new 
			message.content = r['text']
			message.save
			render json: message
		end
	end
end
