class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :review

  def comment_params
    params.require(:comment).permit(:review_id, :user_id, :comment_title,:comment_body)
  end

end
