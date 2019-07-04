class ChargesController < ApplicationController 

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      amount: 15_00
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
 
    charge = Stripe::Charge.create(
      customer: customer.id, 
      amount: 15_00,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    current_user.update_attribute(:role, 'premium_member')
 
    flash[:notice] = "Your transaction has been approved, #{current_user.email}! You are now a Premium Member of Blocipedia."
    redirect_to root_path(current_user) 

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def downgrade
    current_user.update_attribute(:role, 'standard_member')
    current_user.wikis.update_all(private: false)
    
    flash[:notice] = "Your account has been changed back to a standard free membership."
    redirect_to new_charge_path 
  end

end