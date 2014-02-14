class OrdersController < ApplicationController
  protect_from_forgery except: [:create]
  def create
    if params["campaign_id"] == ENV['MOGREET_CAMPAIGN_ID']
      Order.process_incoming_mms(params)
      render nothing: true
    else
      render nothing: true
    end
  end

  def index
    past_orders = current_user.orders
    past_recipients = past_orders.map { |x| Recipient.find_by(lob_id: x.lob_address_id).name }
    past_order_dates = past_orders.map { |x| x.created_at.to_date }

    date_name_combo = past_recipients.zip(past_order_dates)
    past_order_urls = past_orders.map { |x| x.photo_web_url }

    @display_data = Hash[past_order_urls.zip(date_name_combo)]
  end
end
