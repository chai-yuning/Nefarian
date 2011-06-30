class Quest < ActiveRecord::Base
  
  belongs_to :user
  
  validates :user_id, :presence => true
  validates :quest_id, :presence => true
  
  default_scope :order => 'quests.created_at DESC'
  
end
