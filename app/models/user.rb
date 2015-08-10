class User < ActiveRecord::Base

  class << self
    def create_or_update(uid)
      begin
        user_info = HTTParty.get("http://localhost:3000/me.json?token=#{uid}")
        user = where(uid: uid).first
        if user
          user.update_attributes(user_attributes(user_info))
        else
          User.create!(user_attributes(user_info))
        end
        return true
      rescue
        Listener.channel.recover
        sleep 10
      end
    end

    def user_attributes(user_info)
      {
          email: user_info["email"],
          first_name: user_info["first_name"],
          last_name: user_info["last_name"],
          uid: user_info["token"]
      }
    end
  end
end
