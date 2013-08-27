require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)

  test "a user should enter a first name" do 
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?

  end

  test "a user should enter a last name" do 
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do 
  	user = User.new
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end
test "a user should have a unique a profile name" do 
  	user = User.new
user.profile_name = users(:divya).profile_name

  	assert !user.save
  	
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
   user = User.new(first_name: 'divya', last_name: 'nagpal', email: 'divyar2008@gmail.com' )
    user.password = user.password_confirmation = 'crappyyyy'
   user.profile_name = "My profile with spaces"
   assert !user.save
  	assert !user.errors[:profile_name].empty?
  	assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end

  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'divya', last_name: 'nagpal', email: 'divyar2008@gmail.com' )
    user.password = user.password_confirmation = 'crappyyyy'
    user.profile_name = 'divyanagpal_1'
    assert user.valid?
  end
  test "that no error is raised when trying to access a friend list" do
    assert_nothing_raised do
      users(:divya).friends
    end
  end
  test "that creating friendships on a user works" do
    users(:divya).friends << users(:mike)
    users(:divya).friends.reload
    assert users(:divya).friends.include?(users(:mike))
  end
test "that creating a friendship based on user id and friend id works" do
  UserFriendship.create user_id: users(:divya).id, friend_id: users(:mike).id
  assert users(:divya).friends.include?(users(:mike))
end
end
