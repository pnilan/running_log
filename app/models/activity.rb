class Activity < ActiveRecord::Base
	belongs_to :user
	# has_one :type
	default_scope -> { order('date DESC') }

	validates :date, :user_id, :type_id, presence: true
	validates :content, length: { maximum: 1000 }
	validates :pace, presence: true, if: "distance.present? && duration.present?"
end
