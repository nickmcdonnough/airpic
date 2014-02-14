# Airpic!

### What is it?
This is my first Rails project.  It is a service that allows a user to send an MMS message to our shortcode with an image attached and then have that image sent as a postcard with a custom message to any US address the user specifies.  

### Is it live anywhere?
It's currently running on Heroku while I test things out.  You can check it out [here](https://airpic.herokuapp.com "Airpic").

### Is it free?
It is free to sign up but will cost one stamp ($2) to send a postcard.

### How do I send a postcard?
First, sign in to your account.  If you do not have any addresses saved you should add at least one first.  You will also need at least 1 stamp in your account to send a postcard.  Once these two things are taken care of simple venture outside, snap a photo, and MMS it to '343434.'  The message accompanying the photo should be formatted as such "airpic to_name message."  For example "airpic jill Hey Jill, I just wanted to share this beautiful picture of Lake Austin!"


## Tools & Services that make Airpic work

### Mogreet (www.mogreet.com)
Mogreet is used to handle inbound and outbound MMS and SMS messaging.  I chose Mogreet because of it's well documented API, simple price structure, and good customer service.  

### Lob (www.lob.com)
Lob handles the printing and mailing of the postcards.  The primary reason I chose lob is because of it's incredibly simple API and superb documentation of that API.  The prices are great as well.  Lob is also a new company (YC S13) and I like the idea of supporting something fresh.

### Stripe (www.stripe.com)
As mentioned earlier, users needs virtual stamps in order to send postcards with Airpic.  Stripe is the payment processor that handles the collection of credit card data in order for users to purchase Airpic stamps.  Like Mogreet and Lob, I chose Stripe because it has a really easy to undersatnd API and it was a breeze to integrate their Checkou form (built on stripe.js) into my own application.  The major downside to stripe is the price.  They charge 2.9% plus $0.30 per successful charge.  Because of this I shouldn't really allow users to purchase stamps one stamp at a time.  I intend to find a payment processor that can support micropayments.

## To do:
Major overhaul on the front end including:
	- an informative home page
	- an informative landing page
	- an attractive way to interact with postcards already sent
Create a way for users to upload photos via the web
Find a new payment processor