#Reference: Mailboxer and private messaging tutorial
#From: http://josephndungu.com/tutorials/private-inbox-system-in-rails-with-mailboxer
class ConversationsController < ApplicationController
	before_action :logged_in_user

	def new
		
	end

	def create
		recipients = User.find(conversation_params[:recipients].to_i)
		if conversation_params[:body].strip=="" || conversation_params[:subject].strip==""
			flash[:notice] = "Body and subject cannot be blank"
			redirect_to new_conversation_path(:id=>recipients.id)
		else
			conversation = current_user.send_message(recipients, conversation_params[:body], conversation_params[:subject]).conversation
			flash[:success] = "Message sent to "+recipients.first
			redirect_to conversation_path(conversation)
		end
	end

	def show
		@receipts = conversation.receipts_for(current_user).paginate(:page=> params[:page], per_page: 5)
	end

	def reply
		if message_params[:body] != ''
			current_user.reply_to_conversation(conversation, message_params[:body])
			flash[:success] = "Your reply was sent"
		else
			flash[:success] = "Your body cannot be empty"
		end
		redirect_to conversation_path(conversation)
	end

	def trash
		conversation.move_to_trash(current_user)
		flash[:success] = "The conversation was moved to trash"
		redirect_to mailbox_trash_path
	end

	def clear
		conversation.destroy
		flash[:success] = "Conversation deleted"
		redirect_to mailbox_trash_path
	end
	

	def untrash
		conversation.untrash(current_user)
		flash[:success] = "The conversation was successfully untrash"
		redirect_to mailbox_inbox_path
	end
	

	def trash_all
		flash[:success] = "it did go here"
		redirect_to mailbox_trash_path
	end

	private
	 def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in to post"
        redirect_to login_url
      end
    end

    def conversation_params
    	params.require(:conversation).permit(:subject, :body, :recipients)
    end

    def message_params
    	params.require(:message).permit(:body, :subject)
    end

end
