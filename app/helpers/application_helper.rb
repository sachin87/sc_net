module ApplicationHelper

  def yes_no(bool)
    if bool == true
      "yes"
    else
      "no"
    end
  end

  def rel_tag(user, friendship)
    rel_tag = []
    if user.id == friendship.friend.id
      # identity
      rel_tag << 'me'
    else
      # friendship
      rel_tag << 'friend' if friendship.friend
      rel_tag << 'acquaintance' if friendship.acquaintance
      rel_tag << 'contact' if friendship.contact
      # physical
      rel_tag << 'met' if friendship.met
      # professional
      rel_tag << 'co-worker' if friendship.coworker
      rel_tag << 'colleague' if friendship.colleague
      # geographical
      rel_tag << 'co-resident' if friendship.coresident
      rel_tag << 'neighbor' if friendship.neighbor
      # family
      rel_tag << 'kin' if friendship.kin
      rel_tag << 'child' if friendship.child
      rel_tag << 'parent' if friendship.parent
      rel_tag << 'sibling' if friendship.sibling
      rel_tag << 'spouse' if friendship.spouse
        
      # romantic
      rel_tag << 'muse' if friendship.muse
      rel_tag << 'crush' if friendship.crush
      rel_tag << 'date' if friendship.date
      rel_tag << 'sweetheart' if friendship.sweetheart
    end
    rel_tag.join(' ')
  end


end
