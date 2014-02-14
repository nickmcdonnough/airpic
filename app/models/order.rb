require 'messaging.rb'

class Order < ActiveRecord::Base
  belongs_to :user
  has_one :card

  @lob = Lob(api_key: ENV['LOB_TEST']) #change to 'LOB_API_KEY'

  def self.process_incoming_mms(incoming)
    sender = User.lookup_sender(incoming) # check that incoming number is in db
    recipient = sender.lookup_recipient(incoming) # finds recipient. returns lob_id
    photo_urls = Card.get_photo(incoming, sender)
    photo_pdf_url = photo_urls[0]
    photo_web_url = photo_urls[1]
    message = Card.get_message(incoming)

    if !sender || !recipient || !photo_pdf_url || !message
      return false
    end

    if sender.stamp_collection >= 1
      send_order_to_lob(sender, recipient, photo_pdf_url, photo_web_url, message)
      sender.print_stamp(-1, Time.now.to_i, "Card sent to: #{recipient}")
    else
      Messaging.send_sms(:a, sender.mobile) # not enough credits
      return 
    end
  end

  def self.send_order_to_lob(sender, to_lob_id, photo_pdf_url, photo_web_url, message)
    from_address = {
      name: "#{sender.first_name} #{sender.last_name} courtesy of AirPic!",
      address_line1: '2520 Elmont Drive',
      address_line2: '#220A',
      city: 'Austin',
      state: 'TX',
      country: 'US',
      zip: '78741'
    }

    lob_order = @lob.postcards.create(
      name: "#{sender.id}_#{Time.now.to_i}",
      to: to_lob_id,
      from: from_address,
      front: photo_pdf_url,
      message: message
    )

    sender.orders << Order.create(
      lob_address_id: to_lob_id,
      lob_job_id: lob_order['id'],
      photo_pdf_url: photo_pdf_url,
      photo_web_url: photo_web_url,
    )
  end
end