class MessagesController < ApplicationController

	private
		def message_params
			params[:content]
		end
end
