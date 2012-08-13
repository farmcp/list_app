module ActsAsStory

  def self.included(base)
    base.extend ActsAsStory::ClassMethods
  end

  module ClassMethods
    def acts_as_story
      include ActsAsStory::InstanceMethods

      has_one :story, :as => :subject, :dependent => :destroy
      after_create :storify!
    end
  end

  module InstanceMethods
    private
    def storify!
      build_story(:user => user).save!
    end
  end

end

ActiveRecord::Base.send(:include, ActsAsStory)
