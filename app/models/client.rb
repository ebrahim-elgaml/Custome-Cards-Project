class Client < ActiveRecord::Base
	belongs_to :user , class_name: 'User' ,foreign_key: "user_id", :dependent => :destroy
	validates_associated :user
	validates_presence_of :user
	validates_uniqueness_of :user_id

	def to_s
		"#{user}"
		
	end
end
