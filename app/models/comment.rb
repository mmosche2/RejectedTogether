class Comment < ActiveRecord::Base
  belongs_to :user
  attr_accessible :answer_id, :body, :user_id



end
