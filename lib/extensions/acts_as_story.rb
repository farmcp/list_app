module ActsAsStory

  def self.included(base)
    base.extend ActsAsStory::ClassMethods
  end

  module ClassMethods
    def acts_as_story(options = {})
      include ActsAsStory::InstanceMethods
      has_one :story, :as => :subject, :dependent => :destroy
      after_create :storify!
      cattr_accessor :story_fields
      self.story_fields = options.delete(:story_fields) { [] }
    end
  end

  module InstanceMethods
    private
    def storify!
      options = { user: user }
      story_fields.each do |field|
        options[field] = self.send(field)
      end
      build_story(options).save!
    end
  end

end

ActiveRecord::Base.send(:include, ActsAsStory)
