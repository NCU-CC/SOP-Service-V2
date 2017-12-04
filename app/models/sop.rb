class Sop < ActiveRecord::Base

  def self.select_by_params p
    sop = Sop.select(Sop.column_names - ['steps'])
    unless p[:marker]
      sop = sop.order updated_at: :desc
      sop = sop.where author: p[:author] if p[:author]
      sop = sop.limit p[:limit] if p[:limit]
      sop = sop.offset p[:offset] if p[:offset]
    else
      sop = sop.where 'id IN (SELECT sop_id FROM marks WHERE uid=?)', p[:marker]
    end
    sop.all
  end

  def self.update_by_params p
    sop_id = p[:id]
    p.delete :id
    unless p.empty?
      sop = Sop.find_by_id sop_id
      sop.update(**p.symbolize_keys)
    else
      false
    end
  end

  def self.remove id, user_id
    Sop.destroy_all id: id, author: user_id
  end

  def steps
    JSON.parse self[:steps]
  end

  def steps= val
    self[:steps] = JSON.dump val
  end

end
