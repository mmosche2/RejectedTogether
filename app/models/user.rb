class User < ActiveRecord::Base
  attr_accessible :email, :question_id, :ame_user_id, :pw_token

  validates_uniqueness_of :email
end
