#Reference: Mailboxer and private messaging tutorial
#From: http://josephndungu.com/tutorials/private-inbox-system-in-rails-with-mailboxer
class MailboxController < ApplicationController
	before_action :logged_in_user

	def inbox
		@inbox = mailbox.inbox.paginate(:page=> params[:page], per_page: 3)
		@active = :inbox
	end

	def sent
		@sent = mailbox.sentbox.paginate(:page=> params[:page], per_page: 3)
		@active = :sent
	end

	def trash
		@trash = mailbox.trash.paginate(:page=> params[:page], per_page: 3)
		@active = :trash
	end

	def trash_all
		flash[:success] = "it did go here2"
		redirect_to mailbox_trash_path
	end

  private
	def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in to post"
        redirect_to login_url
      end
    end
end
