require 'test_helper'

class UsersTest < ActiveSupport::TestCase
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Replace this with your real tests.
  test "This finds unexpected errors" do
    assert true
  end

  ## Tried to reference :username in fixture with  #Users(:one).username, and it didn't work.... with 
  ## various attempts with user, users, User, Users... nada.  Documentation states that the naming should be 
  ## consistent with fixture file name 


  test "User name unique" do
    user = Users.new(:username   =>  "lizabeth"  , #Users(:one).username,
			      :password   =>"",
			      :email      =>"",
			      :first_name =>"lizqq",
			      :MI         =>"q",
			      :last_name  =>"asdasqq",
			      :role       =>"nonadmin",
			      :created_at  => DateTime.now,
			      :placed_at   => DateTime.now,
			      :machine_ip =>"asdf",
			      :approved    =>1  )
    assert !user.save
    assert_equal "has already been taken" , user.errors.on(:username)
  end

 test "Email not properly formatted" do
    user = Users.new(:username   =>  "Beth12345"  , #Users(:one).username,
			      :password   =>"",
			      :email      =>"",
			      :first_name =>"lizqq",
			      :MI         =>"q",
			      :last_name  =>"asdasqq",
			      :role       =>"nonadmin",
			      :created_at  => DateTime.now,
			      :placed_at   => DateTime.now,
			      :machine_ip =>"asdf",
			      :approved    =>1  )
    assert !user.save
    assert_match( email_regex, user.email, "email NOT properly formatted")
  end

end
