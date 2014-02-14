class Recipient < ActiveRecord::Base
  validates_presence_of :nickname, :name, :address_line1, :city, :state, :zip
  belongs_to :user

  @lob = Lob(api_key: ENV['LOB_API_KEY'])
  
  def self.save_lob_id_in_db(recipient_id, lob_id)
    r = Recipient.find(recipient_id)
    r.lob_id = lob_id
    r.save
  end

  def self.save_address_to_lob(recipient_from_web)
    r = { country: 'US' } #lob.addresses.create requires :country
    recipient_from_web.each_pair do |x, y|
      r.merge!(x.to_sym => y)
    end
    addy = @lob.addresses.create(r)
    addy["id"]
  end

  def self.delete_address_from_lob(lob_id)
    if lob_id
      @lob.addresses.destroy(lob_id)
    end
  end
end
