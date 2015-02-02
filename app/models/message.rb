class Message < ActiveRecord::Base
	
	def self.process
		this_message = Message.order("created_at DESC").first
		c = this_message.content
		this_message.destroy
		return c
	end
end
