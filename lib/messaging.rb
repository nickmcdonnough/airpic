#
# These are a few methods needed for interacting with Mogreet.  Top of the list
# of things to be cleaned up.
#

require 'net/http'
require 'uri'

module Messaging
  def self.send_sms(code, mobile)
    message = get_message(code)
    mogreet = URI.parse(
      "https://api.mogreet.com/moms/transaction.send?" +
      "client_id=4984" +
      "&campaign_id=52383" +
      "&token=#{ENV['SECRET_MOGREET_TOKEN']}" +
      "&to=#{URI.encode(mobile)}" +
      "&message=#{URI.encode(message)}" +
      "&format=json"
    )
    req = Net::HTTP::Get.new(mogreet.path)
    res = Net::HTTP.start(mogreet.host, mogreet.port) { |h| h.request(req) }
    # res.body contains response
  end

  def self.get_message(code)
    message_list = {
      a: "Sorry. You do not have enough credits to fulfill your order. Please refill at www.airpic.com.",
      b: "You must include a photo with your message. Please resend your photo and message.  Thank you.",
      c: "You must include a message with your photo. Please resend your photo with a message. Thank you.",
      d: "You are not an existing AirPic user. Please go to www.airpic.io to sign up!",
      e: "Could not find the recipient in your address book.",
      f: "AirPic cannot handle square photos right now. Please adjust your cameras settings and resend. Thank you."
    }
    message_list[code]
  end
end