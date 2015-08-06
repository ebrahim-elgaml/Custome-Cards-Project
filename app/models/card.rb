class Card < ActiveRecord::Base
	validates_associated :added_by
	validates_presence_of :added_by
	belongs_to :added_by , class_name: 'User' ,foreign_key: "added_by_id"
	belongs_to :type
	validates_associated :type
	validates_presence_of :type
	belongs_to :taken_by , class_name: 'User' ,foreign_key: "taken_by_id"
	validates_associated :taken_by
	validates_presence_of :number
	validates_numericality_of :number, :allow_blank => true
	validates_uniqueness_of :number

	after_save :set_taken_time
	
	def set_taken_time
		if self.taken_at.blank? and self.is_taken
			self.taken_at = Time.current
			self.save
		end	
	end

	def to_s
		"#{number} added by #{added_by} with typw #{type}"	
	end
	
end
