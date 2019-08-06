class RestaurantPolicy < ApplicationPolicy
  # Scope is for defining access to a class level (in our case Restaurant class)
  class Scope < Scope
    def resolve
      scope.all
      # in case if you have multiple user tiers, or want a user to only see the list of their own objects you can use something like this:
      # scope.where(user: user)
    end
  end

  # each policy rule corresponds to the name of a controller action and should return true or false
  # true means 'authorized'
  # false means 'not authorized'
  def new?
    create?
  end

  def create?
    true
  end

  def show?
    true
  end

  # in case of updating and deleting we want only to owners of a record or admins to be able to do those actions
  def edit?
    user_is_owner_or_admin?
  end

  def update?
    user_is_owner_or_admin?
  end

  def destroy?
    user_is_owner_or_admin?
  end

  private

  def user_is_owner_or_admin?
    record.user == user or user.admin
  end
end
