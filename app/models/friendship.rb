class Friendship < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :friend, :class_name => 'User', :foreign_key => 'friend_id'

  def friendship=(friendship_type)
    self.friend = false
    self.acquaintance = false
    self.contact = false
    case friendship_type
    when 'friend'
      self.friend = true
    when 'acquaintance'
      self.acquaintance = true
    when 'contact'
      self.contact = true
    end
  end

  def friendship
    return 'friend' if self.friend == true
    return 'acquaintance' if self.acquaintance == true
    return 'contact' if self.contact == true
    false
  end
  
  def geographical=(geo_type)
    self.coresident = false
    self.neighbor = false
    case geo_type
    when 'coresident'
      self.coresident = true
    when 'neighbor'
      self.neighbor = true
    end
  end

  def geographical
    return 'coresident' if self.coresident
    return 'neighbor' if self.neighbor
    false
  end
  
  def family=(family_type)
    self.child = false
    self.parent = false
    self.sibling = false
    self.spouse = false
    self.kin = false
    case family_type
    when 'child'
      self.child = true
    when 'parent'
      self.parent = true
    when 'sibling'
      self.sibling = true
    when 'spouse'
      self.spouse = true
    when 'kin'
      self.kin = true
    end
  end
  
  def family
    return 'child' if self.child
    return 'parent' if self.parent
    return 'sibling' if self.sibling
    return 'spouse' if self.spouse
    return 'kin' if self.kin
    false
  end

end