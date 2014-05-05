class Activity < ActiveRecord::Base
	belongs_to :user
	# default_scope -> { order('date DESC') }

	# validates :type
	# validates :distance
	# validates :duration
	# validates :user_id, presence: true

end
