class ChargesController < ApplicationController

    def new
    end
    
    def create
      @price = Items.find(params[:price])
      puts "="*80
      puts params
      puts "="*80
    
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })
    
      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @price,
        description: 'Rails Stripe customer',
        currency: 'usd',
      })
    
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end

end
