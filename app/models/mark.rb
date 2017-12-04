class Mark < ActiveRecord::Base

  def self.exist? id, user_id
    (Mark.where sop_id: id, uid: user_id).size > 0
  end

  def self.add id, user_id
    Mark.create! uid: user_id, sop_id: id
  end
  
  def self.del id, user_id
    Mark.destroy_all uid: user_id, sop_id: id
  end

  def self.by_user user_id
    Mark.where(uid: user_id).map { |row| row[:sop_id] }
  end

end
