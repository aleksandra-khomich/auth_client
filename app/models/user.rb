class User < ActiveRecord::Base
  include MultipleMan::Subscriber
  subscribe fields: [:id, :email, :first_name, :last_name]
end
