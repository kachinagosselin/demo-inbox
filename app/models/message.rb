	require 'mandrill'
	class Message < ActiveRecord::Base
		default_scope { order('created_at ASC') }

		def self.display_date(date, style)
			if style == "linebreak"
				return date.strftime("%b %-d, %Y </br> @ %l:%M %p").html_safe
			elsif style == "date"
				return date.strftime("%b %-d '%y")
			elsif style == "time"
				return date.strftime("%l:%M %p")
			else
				return date.strftime("%b %-d, %Y @ %l:%M %p")
			end
		end

		def recipient(user)
			return User.find(self.recipient_id).email if recipient_id != user.id
			return User.find(self.sender_id).email if sender_id != user.id
		end

		def send
			mandrill = Mandrill::API.new('HrP20kIzVEQpG7NZItUxZg')
			message = {:subject => "Test Title", :text => m.content, :to_email => User.find(m.recipient_id).email, :from_email => User.find(m.sender_id).email, :from_name => User.find(m.sender_id).email}
			result = mandrill.messages.send(message)
			#self.update_attributes(email_id: result[0]['_id'])
		end
	end
