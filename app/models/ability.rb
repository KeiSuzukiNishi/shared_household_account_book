class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can :manage, IncomesExpense
      if user.admin?
        can :manage, :all
      end
    end
  end
end