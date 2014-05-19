FactoryGirl.define do
	factory :user do
		sequence(:username) { |n| "Person#{n}"}
		sequence(:name) 	{ |n| "Person #{n}"}		
		sequence(:email) 	{ |n| "Person_#{n}@example.com"}
		password "foobar"
		password_confirmation "foobar"
		password_reset_token "anything"

		factory :admin do
			admin true
		end
	end
end