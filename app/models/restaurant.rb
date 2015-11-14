class Restaurant < ActiveRecord::Base
	belongs_to :owner

	validates_presence_of :name

	def is_owner?(an_owner)
		self.owner_id == an_owner.id
	rescue
		false
	end
end
