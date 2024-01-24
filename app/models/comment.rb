class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :review

  validates :comment_title, presence: true
  validates :comment_body, presence: true

  def comment_params
    params.require(:comment).permit(:review_id, :user_id, :comment_title,:comment_body)
  end

end
