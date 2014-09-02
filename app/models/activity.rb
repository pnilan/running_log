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
		activities = Activity.where('user_id= ? AND date = ?', current_user.id, Date.today)

		activities.each do |activity|
			if activity.distance != nil
				distance += activity.distance
			end
		end
		distance.round(1)
	end

	def self.distance_this_week(current_user)
		distance = 0
		if Date.today.wday != 1
			activities = Activity.where('user_id= ? AND date >= ? AND date < ?', current_user.id, Chronic.parse('last monday'), Chronic.parse('next monday'))
		else
			activities = Activity.where('user_id= ? AND date >= ? AND date < ?', current_user.id, Date.today, Chronic.parse('next monday'))
		end

		distance = activities.sum(:distance).round(1)
	end

	def self.distance_this_month(current_user)
		distance = 0
		activities = Activity.where('user_id= ? AND date >= ? AND date < ?', current_user.id, Chronic.parse('the first of this month'), Chronic.parse('the first of this month') + 1.month)

		activities.each do |activity|
			if activity.distance != nil
				distance += activity.distance
			end
		end
		distance.round(1)
	end

	def self.this_week
		days = 1..7
		distances = []

		days.each do |day|
			if day < Date.today.wday
				distances << where('date = ?', Chronic.parse('last #{Date::DAYNAMES[day]}')).sum(:distance).round(1)
			elsif day > Date.today.wday
				distances << where('date = ?', Chronic.parse(Date::DAYNAMES[day])).sum(:distance).round(1)
			else
				distances << where('date = ?', Date.today).sum(:distance).round(1)
			end
		end
		distances
	end

	def chrono_duration
		if self.duration
			ChronicDuration.output(self.duration, format: :chrono)
		end
	end
end
