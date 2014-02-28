require 'RMagick'
require 'messaging.rb'

class Card < ActiveRecord::Base
  belongs_to :sender
  belongs_to :order

  def self.get_photo(incoming, sender)
    if !incoming['images']
      Messaging.send_sms(:b, incoming['msisdn']) # send sms saying no picture
      return false
    else
      photo_url = incoming['images'][0]['image']
      photo = Magick::Image.read(photo_url).first
      resize_photo(photo, sender)
    end
  end

  def self.resize_photo(photo, sender)
    photo_name = "#{sender.id}_#{Time.now.to_i}"
    if photo.rows > photo.columns # check for portrait orientation
      new_photo = photo.resize_to_fill(1200,1800)
    elsif photo.rows < photo.columns # check for landscape orientation
      new_photo = photo.resize_to_fill(1800,1200)
    else
      Messaging.sms(:f, sender.mobile) # some response for a square photo
      return false
    end
    new_photo.density = '300x300'
    new_photo.write("tmp_pics/#{photo_name}.pdf")
    new_photo.write("tmp_pics/#{photo_name}.png")
    
    pic_pdf_url = send_to_s3(sender.id, File.basename("tmp_pics/#{photo_name}.pdf"))
    pic_web_url = send_to_s3(sender.id, File.basename("tmp_pics/#{photo_name}.png"))

    return pic_pdf_url, pic_web_url
  end

  def self.get_message(incoming)
    message = incoming['message'].split[2..-1].join(' ')
    if message == nil
      sender.sms(:c, incoming['msisdn']) # code 5 for missing message
      return false
    else
      return message
    end
  end

  def self.send_to_s3(sender_id, file) # method returns the public url for the picture for lob.
    #cleanup_old_pics #this isnt working yet
    
    AWS::S3::Base.establish_connection!(
      access_key_id: ENV['S3_ACCESS_KEY'],
      secret_access_key: ENV['S3_SECRET_KEY']
    )

    AWS::S3::S3Object.store(
      file,
      File.open(file), # question this. seems to work so far.
      "airpic/#{sender_id}/",
      access: :public_read
    )

    AWS::S3::S3Object.url_for(file, "airpic/#{sender_id}/", authenticated: false)
  end

  def self.cleanup_old_pics
    Dir.glob("tmp_pics/*").each do |file|
      if (Time.now - File.ctime(file))/(24*3600) > 2
        File.delete(file) 
      end
    end
  end
end