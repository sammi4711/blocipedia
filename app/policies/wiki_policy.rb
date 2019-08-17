class WikiPolicy < ApplicationPolicy

  class Scope
    attr_reader :user, :scope
 
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all
      else
        scope.where(
          private: [false, nil] || wiki.user.email == current_user.email || wiki.collaborators.include?(user)
        )
      end
    end
  end
end