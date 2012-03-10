class Message < ActiveRecord::Base
  belongs_to :user ,:foreign_key => "sender_id"
  is_private_message
  
  # The :to accessor is used by the scaffolding,
  # uncomment it if using it or you can remove it if not
  #attr_accessor :to
  
end