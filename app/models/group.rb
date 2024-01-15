class Group < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :members, through: :user_groups, source: :user
end
