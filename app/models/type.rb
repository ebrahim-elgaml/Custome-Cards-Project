class Type < ActiveRecord::Base
	has_many :cards
	validates_presence_of :value , :message => "value can't be empty"
	validates_numericality_of :value
	validates_uniqueness_of :value
	def to_s
		"#{value}"	
	end
end
