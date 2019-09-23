class WikiPolicy < ApplicationPolicy

  class Scope
    attr_reader :user, :scope
 
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def index?
      true
    end

    def resolve
      wikis = []
      if user.admin?
        wikis = scope.all
      elsif user.premium_member?
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.private == false || wiki.user == user || wiki.users.include?(@user)
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.private == false || wiki.users.include?(@user)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end

end