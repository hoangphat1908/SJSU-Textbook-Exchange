module ApplicationHelper
	def active_page(active_page)
		@active_page == active_page ? "active" : ""
	end	
end
