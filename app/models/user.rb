class User

  attr_reader :profile_pic, :name, :username

  def initialize(username)
    @username = username
    @name = @user_info
    @user_info = get_user_info
    @repos = get_repos
  end

  private def get_user_info
    HTTParty.get("https://api.github.com/users/#{@username}",
      headers: {"Authorization" => "token #{ENV["GITHUB_KEY"]}",
                   "User-Agent" => "cruznunez"
      }
    )

  end

  private def get_repos
    HTTParty.get("https://api.github.com/users/#{@username}/repos")
  end

  def get_pic
    @user_info["avatar_url"]
  end

  def name
    @user_info["name"]
  end

  def repo_len
    @repos.length
  end

  def email
    @user_info["email"]
  end

  def joined
    hash = {
      "01" => "Jan",
      "02" => "Feb",
      "03" => "Mar",
      "04" => "Apr",
      "05" => "May",
      "06" => "Jun",
      "07" => "Jul",
      "08" => "Aug",
      "09" => "Sep",
      "10" => "Oct",
      "11" => "Nov",
      "12" => "Dec"
    }
    string = @user_info["created_at"]
    year = string[0..3]
    month = hash[string[5..6]]
    day = string[8..9]
    "Joined on #{month} #{day}, #{year}"
  end

  def profile_pic

  end
end
