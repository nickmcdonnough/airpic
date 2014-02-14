class User < ActiveRecord::Base
  has_many :stamps
  has_many :orders
  has_many :cards
  has_many :recipients, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name

  def self.lookup_sender(incoming)
    incoming_mobile = incoming["msisdn"]
    incoming_mobile[0] = ''
    p incoming_mobile
    sender = find_by mobile: incoming_mobile
    if sender == nil
      Messaging.send_sms(:d, incoming['msisdn'])
      return false
    end
    sender
  end

  def lookup_recipient(incoming)
    r = incoming['message'].split[1].downcase.gsub(/\W/, '')
    nr = recipients.find_by nickname: r

    if !nr
      Messaging.send_sms(:e, incoming['msisdn'])
      return false
    end

    return nr.lob_id if nr.lob_id
  end

  def print_stamp(quantity, date, notes)
    stamps << Stamp.create(quantity: quantity, date: date, notes: notes)
  end

  def stamp_collection
    stamps.sum('quantity')
  end
end