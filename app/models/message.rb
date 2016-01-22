class Message < ActiveRecord::Base
	 acts_as_readable :on => :created_at
  belongs_to :conversation
  belongs_to :user
	validates_presence_of :body, :conversation_id, :user_id
end
