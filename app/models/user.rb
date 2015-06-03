class User

  attr_reader :profile_pic, :name, :username

  def initialize(username)
    @username = username
    @user_info = get_user_info
    @name = name
    @repos = get_repos
    @time_now = get_time
  end

  private def get_user_info
    HTTParty.get("https://api.github.com/users/#{@username}",
      headers: {"Authorization" => "token #{ENV["GITHUB_KEY"]}",
                   "User-Agent" => "cruznunez"
      }
    )

  end

  private def get_repos
    HTTParty.get("https://api.github.com/users/#{@username}/repos",
      headers: {"Authorization" => "token #{ENV["GITHUB_KEY"]}",
                   "User-Agent" => "cruznunez"
      }
    )
  end

  private def get_time
    Time.now
  end

  def pic
    @user_info["avatar_url"]
  end

  def name
    @user_info["name"]
  end

  def email
    @user_info["email"]
  end

  def joined
    hash = {
      "01" => "Jan", "02" => "Feb", "03" => "Mar", "04" => "Apr", "05" => "May",
      "06" => "Jun", "07" => "Jul", "08" => "Aug", "09" => "Sep", "10" => "Oct",
      "11" => "Nov", "12" => "Dec"
    }
    string = @user_info["created_at"]
    year = string[0..3]
    month = hash[string[5..6]]
    day = string[8..9]
    "Joined on #{month} #{day}, #{year}"
  end

  def location
    @user_info["location"]
  end

  def org
    @user_info["company"]
  end

  def followers
    @user_info["followers"]
  end

  def following
    @user_info["following"]
  end

  def stargazers(num)
    @repos[num]["stargazers_count"]
  end

  def forks(num)
    @repos[num]["forks"]
  end

  def repo_len
    @repos.length
  end

  def repo_name(num)
    @repos[num]["name"]
  end

  def repo_updated_at(num)
    github_update_str = @repos[num]["pushed_at"]
    update_str = github_update_str.gsub(/Z/, " -0400")
    old_hour = (update_str[11..12].to_i) - 4
    hour = (old_hour >= 0) ? old_hour : ((24 + old_hour).to_s)
    old_day = update_str[8..9]
    day = (old_hour) > 0 ? old_day : ((old_day.to_i - 1).to_s)
    old_month = update_str[5..6]
    month = day.to_i > 0 ? old_month : old
    year = update_str[0..3]
    min = update_str[14..15]
    sec = update_str[17..18]

    update_time = Time.new(year, month, day, hour, min, sec)
    time_elapsed_seconds = @time_now - update_time
    time_elapsed_seconds
    time_elapsed_days_unrounded = (time_elapsed_seconds.to_f / (24 * 60 * 60).to_f)
    time_elapsed_days = time_elapsed_days_unrounded.round
    "Updated #{time_elapsed_days} days ago"
  end
end
