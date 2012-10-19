class Ability
  include CanCan::Ability

  def initialize(user)
    if user then
      can :manage, Topic, :staff_id => user.id
      can :manage, Comment, :user_id => user.id

      can [:vote, :unvote, :comment, :update], Topic
      cannot [:vote, :unvote], Topic, :staff_id => user.id

      can [:read, :create], [Topic, Comment]
    end
  end
end
