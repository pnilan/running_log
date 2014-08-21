require 'chronic'
require 'chronic_duration'

class Activity < ActiveRecord::Base
	extend SimpleCalendar
	has_calendar attribute: "date"


	
	before_save :parse_duration, :parse_pace

	belongs_to :user
	has_one :type
	default_scope -> { order('date DESC') }

	validates :date, :user_id, :type_id, presence: true
	validates :content, length: { maximum: 1000 }

	def parse_duration
		if self.duration
			self.duration = ChronicDuration.parse(self.duration_before_type_cast)
		end
	end

	def parse_pace
		if self.pace
			self.pace = ChronicDuration.parse(self.pace_before_type_cast)
		end
	end

	def self.distance_today(current_user)
		distance = 0
		activities = Activity.where('user_id= ? AND date > ?', current_user.id, Chronic.parse('yesterday'))

		activities.each do |activity|
			if activity.distance != nil
				distance += activity.distance
			end
		end
		distance
	end

	def self.distance_this_week(current_user)
		distance = 0
		activities = Activity.where('user_id= ? AND date >= ?', current_user.id, Chronic.parse('last monday'))

		activities.each do |activity|
			if activity.distance != nil
				distance += activity.distance
			end
		end
		distance
	end

	def self.distance_this_month(current_user)
		distance = 0
		activities = Activity.where('user_id= ? AND date >= ?', current_user.id, Chronic.parse('the first of this month'))

		activities.each do |activity|
			if activity.distance != nil
				distance += activity.distance
			end
		end
		distance
	end

	def chrono_duration
		if self.duration
			ChronicDuration.output(self.duration, format: :chrono)
		end
	end
end
