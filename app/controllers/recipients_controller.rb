class RecipientsController < ApplicationController
  def new
    @recipient = Recipient.new
  end

  def index
    @address_book = current_user.recipients
  end

  def create
    @recipient = Recipient.new(recipient_params)
    @recipient.user = current_user

    if @recipient.save
      lob_id = Recipient.save_address_to_lob(params[:recipient])
      Recipient.save_lob_id_in_db(@recipient.id, lob_id)
      flash[:success] = "Address saved!"
      redirect_to recipients_path
    else
      flash[:alert] = "There was a problem saving the address."
      redirect_to new_recipient_path
    end
  end

  def edit
    @address_to_edit = Recipient.find(params[:id])
  end

  def update
    recipient = Recipient.find(params[:id])
    recipient.update_attributes(recipient_params)
    recipient.save
    redirect_to recipients_path
  end

  def destroy
    recipient = Recipient.find(params[:id])
    Recipient.delete_address_from_lob(recipient.lob_id)
    recipient.destroy
    redirect_to recipients_path
  end


  private

  def recipient_params
    params.require(:recipient).permit(:nickname, :name, :address_line1, :address_line2, :city, :state, :zip, :user_id)
  end
end