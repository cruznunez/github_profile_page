require 'minitest/pride'
require 'test_helper'
require 'user.rb'


class User
  def get_user_info
    JSON.parse(File.open("./test/models/cruz_user_info.json").read)
  end

  def get_repos
    JSON.parse(File.open("./test/models/cruz_repos.json").read)
  end
end

class UserTest < ActiveSupport::TestCase
  def setup
    @cruz = User.new("cruznunez")
  end

  def test_can_be_created
    assert User.new("cruznunez")
  end

  def test_repository_length
    assert_equal 8, @cruz.repo_len
  end

  def test_username
    assert_equal "cruznunez", @cruz.username
  end

  def test_users_name
    assert_equal "Cruz Nunez", @cruz.name
  end

  def test_email
    assert_equal "nunez.a.cruz@gmail.com", @cruz.email
  end

  def test_joined
    assert_equal "Joined on Sep 11, 2014", @cruz.joined
  end

  def test_repo_name
    assert_equal "", @cruz.repo_name(1)
  end


end
