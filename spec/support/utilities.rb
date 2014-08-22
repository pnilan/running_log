def full_title(page_title)
	base_title = "SecondWind"
	if page_title.empty?
		base_title
	else
		"#{base_title} | #{page_title}"
	end
end

def sign_in(user, options={})
	if options[:no_capybara]
		# Sign in when not using Capybara
		remember_token = User.new_token
		cookies[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.digest(remember_token))
	else
		visit new_session_path
		fill_in "email_signin", 	with: user.email.upcase
		fill_in "password_signin",  with: user.password
		click_button "signin_button"
	end
end