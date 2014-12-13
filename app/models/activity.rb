require 'chronic'
require 'chronic_duration'

class Activity < ActiveRecord::Base
	extend SimpleCalendar
	has_calendar attribute: "date"

	before_save :parse_duration, :parse_pace

	belongs_to :user
	default_scope -> { order('date DESC') }

	validates :date, :user_id, :run_type, presence: true
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
		activities = Activity.where('user_id= ? AND date = ?', current_user.id, Date.current)

		activities.each do |activity|
			if activity.distance != nil
				distance += activity.distance
			end
		end
		distance.round(1)
	end

	def self.distance_this_week(current_user)
		distance = 0
		if Date.current.wday != 1
			activities = Activity.where('user_id= ? AND date >= ? AND date < ?', current_user.id, Chronic.parse('last monday').to_date, Chronic.parse('next monday').to_date)
		else
			activities = Activity.where('user_id= ? AND date >= ? AND date < ?', current_user.id, Date.current, Chronic.parse('next monday').to_date)
		end

		distance = activities.sum(:distance).round(1)
	end

	def self.distance_this_month(current_user)
		distance = 0
		activities = Activity.where('user_id= ? AND date >= ? AND date < ?', current_user.id, Chronic.parse('the first of this month').to_date, Chronic.parse('the first of this month').to_date + 1.month)

		activities.each do |activity|
			if activity.distance != nil
				distance += activity.distance
			end
		end
		distance.round(1)
	end

	def self.this_week
		distances = []

		7.times do |day|
			if day == 0
				if day == Date.current.wday
					distances << where('date = ?', Date.current).sum(:distance).round(1)
				else
					distances << where('date = ?', Chronic.parse('Sunday', context: :future).to_date).sum(:distance).round(1)
				end
			elsif day < Date.current.wday
				distances << where('date = ?', Chronic.parse(Date::DAYNAMES[day], context: :past).to_date).sum(:distance).round(1)
			elsif day > Date.current.wday
				distances << where('date = ?', Chronic.parse(Date::DAYNAMES[day]).to_date).sum(:distance).round(1)
			else
				distances << where('date = ?', Date.current).sum(:distance).round(1)
			end
		end
		distances << distances.shift
	end

	# def self.current_week(output)
	# 	grouped_activities = where('date >= ? AND date <= ?', Date.current.beginning_of_week, Date.current.end_of_week).group('DATE(date)').sum(:distance)
	# 	# if output == 'date'
	# 	# 	grouped_activities.each { |k,v| k.strftime('%-m/%-d/%y') }
	# end

	def chrono_duration
		if self.duration
			ChronicDuration.output(self.duration, format: :chrono)
		end
	end
end
