class BookPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.has_role? :admin
  end
  
  def create?
    user.has_role? :admin
  end
  
  def update?
    user.has_role? :admin
  end

  def delete?
    user.has_role? :admin
  end
end
