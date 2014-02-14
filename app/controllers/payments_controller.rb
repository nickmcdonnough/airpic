class PaymentsController < ApplicationController
  def new
  end

  def index
    @stamp_history = current_user.stamps
  end

  def create
    amount_of_stamps = params[:selStampQuantity].to_i
    amount_of_cents = amount_of_stamps * 200

    customer = Stripe::Customer.create(
      card: params[:stripeToken],
      email: current_user.email
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: amount_of_cents,
      currency: 'usd',
      description: 'Charge for AirPic! stamps.'
    )

    current_user.print_stamp(amount_of_stamps, Time.now.to_i, "Bought stamps through Stripe.")

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to payment_path
  end

end
