class OneOffs
  # OneOffs.add_user_to_list_items
  def self.add_user_to_list_items
    ListItem.all.each do |item|
      item.user = item.list.user
      item.save!
    end
  end

  def self.create_stories

    [ListItem, Comment, List].each do |clazz|
      clazz.all.each do |subject|
        subject.send :storify!
      end
    end
    restaurants = ListItem.includes([:list, :restaurant, :user]).where(:lists => {:user_id => ids}).order('list_items.created_at')
    comments = Comment.includes(:user).where(:user_id => ids).order('created_at')
    lists = List.includes(:user).where(:user_id => ids).order('created_at')
  end
end
