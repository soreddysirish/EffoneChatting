class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
     has_many :conversations, :foreign_key => :sender_id, :dependent => :destroy
     scope :online_users_list, -> { where(status:true)}
      has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
      validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
      enum role: [:admin]
     private

     def create_default_conversation
       Conversation.create(sender_id: 1, recipient_id: self.id) unless self.id == 1
     end

end
