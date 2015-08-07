class User < ActiveRecord::Base
  include MultipleMan::Subscriber
  subscribe fields: [:id, :email, :first_name, :last_name]

  class << self
    def create_or_update(uid)
      user_info = HTTParty.get("http://localhost:3000/user_info.json?token=#{uid}")
      user = where(uid: uid).first
      begin
        if user
          user.update_attributes(user_attributes(user_info))
        else
          User.create!(user_attributes(user_info))
        end
      rescue
        Listener.channel.recover
      end
    end

    def user_attributes(user_info)
      {
          email: user_info["email"],
          first_name: user_info["first_name"],
          last_name: user_info["last_name"],
          token: user_info["token"]
      }
    end
  end
end
