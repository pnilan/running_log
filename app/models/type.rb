class Type < ActiveRecord::Base
	serialize :name, Hash
	validates :name, presence: true
end
