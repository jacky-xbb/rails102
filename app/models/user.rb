class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :groups
  has_many :posts
  has_many :user_groups, dependent: :destroy
  has_many :joined_groups, through: :user_groups, source: :group

  def is_member_of?(group)
    joined_groups.include?(group)
  end

  def join!(group)
    joined_groups << group
  end

  def quit!(group)
    joined_groups.delete(group)
  end
end
