class Note < ActiveRecord::Base
  belongs_to :noteable, :polymorphic => true
  belongs_to :admin_user

  attr_accessible :admin_user_id, :body, :noteable_id, :noteable_type

  def to_s
    body
  end

end
