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

  def get_time
    string = "2015-06-02 19:22:12 -0400"
    year = string[0..3]
    month = string[5..6]
    day = string[8..9]
    hour = string[11..12]
    min = string[14..15]
    sec = string[17..18]
    Time.new(year, month, day, hour, min, sec)
  end
end

class UserTest < ActiveSupport::TestCase
  def setup
    @cruz = User.new("cruznunez")
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
    assert_equal "Currency-Converter", @cruz.repo_name(1)
  end

  def test_updated_at
    assert_equal "Updated 26 days ago", @cruz.repo_updated_at(0)
    assert_equal "Updated 23 days ago", @cruz.repo_updated_at(1)
    assert_equal "Updated 16 days ago", @cruz.repo_updated_at(2)
    assert_equal "Updated 8 days ago", @cruz.repo_updated_at(7)
  end

end
