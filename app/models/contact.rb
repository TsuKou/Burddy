class Contact < ApplicationRecord

  validates :contact_name, presence: true
  validates :contact_title, presence: true
  validates :contact_message, presence: true

  def contact_params
    params.require(:contact).permit(:shop_id, :user_id, :contact_name, :contact_title, :contact_message)
  end

end
