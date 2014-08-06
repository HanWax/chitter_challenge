module SessionHelpers

	def sign_in(email, password)
		visit '/sessions/new'
		fill_in 'email',    :with => email
		fill_in 'password', :with => password
		click_button 'Sign in'
	end

	def sign_up(email = "alice@example.com", chitter_handle = "alice_example", password = "oranges!", password_confirmation = "oranges!")
		visit '/users/new'
		fill_in :email, :with                 => email
		fill_in :chitter_handle, :with        => chitter_handle
		fill_in :password, :with              => password
		fill_in :password_confirmation, :with => password_confirmation
		click_button "Sign up"
	end
	
	def add_peep(content = "testing")
		visit '/peeps/new'
		fill_in :content, :with => content
		click_button 'Send peep'
	end

end