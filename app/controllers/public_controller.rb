class PublicController < ApplicationController

	def display
		c = Message.process
		render plain: c
	end


end
