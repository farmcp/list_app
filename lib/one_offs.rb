class OneOffs
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
