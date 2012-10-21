class Ability
  include CanCan::Ability

  def initialize(user)
    if user then
      can :manage, Topic, :staff_id => user.id
      can :manage, Comment, :user_id => user.id

      can [:register, :comment, :update], Topic

      # > itsuhane(29888088)  23:29:40
      # > 话说，@quark 求创建者投自己的 topic 的能力 >_<
      # cannot [:vote, :unvote], Topic, :staff_id => user.id

      can [:read, :create], [Topic, Comment]
    end
  end
end
