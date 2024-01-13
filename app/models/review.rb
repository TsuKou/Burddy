class Review < ApplicationRecord

  has_many :comments, dependent: :destroy
  # has_many :favorites, dependent: :destroy

  belongs_to :user
  belongs_to :shop


end
