class Contact < ApplicationRecord

  def contact_params
    params.require(:contact).permit(:shop_id, :user_id, :contact_name, :contact_title, :contact_message)
  end

end
