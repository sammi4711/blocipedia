module WikisHelper
    def private_wikis?(current_user)
    current_user.premium? || current_user.admin?
  end
end
