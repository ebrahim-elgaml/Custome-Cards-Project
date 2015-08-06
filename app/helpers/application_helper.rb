module ApplicationHelper
	def is_number? string
	  true if Integer(string) rescue false
	end
end
