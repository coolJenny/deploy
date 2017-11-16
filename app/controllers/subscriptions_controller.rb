class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  layout 'subscription'
  # require "stripe"
  def index
  end
  def create
  	subscription = Stripe::Plan.create(
	  :amount => (params[:amount].to_i)*100,
	  :interval => params[:interval],
	  :name => params[:name],
	  :currency => 'usd',
	  :id => SecureRandom.uuid # This ensures that the plan is unique
	)
	#Save the response to your DB
	flash[:notice] = "Plan successfully created"
  	redirect_to '/subscription'
  end

  def plans
  	@stripe_list = Stripe::Plan.all
  	@plans = @stripe_list[:data]
    @plans = @plans.reverse
  end

  def stripe_checkout
    current_user.subscription_id = "stripe_subscription.id"
    current_user.save
    redirect_to '/skynets/new'
		# @amount = params[:amount]
    # @code = params[:couponCode]
    # @final_amount = @amount
    # if !@code.blank?
    #   @discount = get_discount(@code)
    #   if @discount.nil?
    #     redirect_to '/plans', :flash => { :coupon_error => "Coupon code is not valid or expired." } 
    #     return
    #     @discount = 0
    #     @code=""
    #   else
    #     @discount_amount = @amount * @discount
    #     @final_amount = @amount.to_i - @discount_amount.to_i
    #   end

    #   charge_metadata = {
    #     :coupon_code => @code,
    #     :coupon_discount => (@discount * 100).to_s + "%"
    #   }
    # end
    # @plan_id = params[:plan_id]
    # @plan = Stripe::Plan.retrieve(@plan_id)
    # customer = Stripe::Customer.create(
    #   :description => "Customer for" + current_user.email,
    #   :source => params[:stripeToken],
    #   :email => current_user.email
    # )
    # charge = Stripe::Charge.create(
    #     :customer    => customer.id,
    #     :amount => @amount,
    #     :currency => "usd",
    #     :description => "Charge",
    #     :metadata    => charge_metadata
    # )
    # flash[:notice] = "Successfully created a charge"
    # stripe_subscription = customer.subscriptions.create(:plan => @plan.id)
    # @interval =  stripe_subscription.items.data[0].plan.interval
    # @amount =  stripe_subscription.items.data[0].plan.amount
    # @created =  stripe_subscription.items.data[0].plan.created
    # subscription = Subscription.where(:subscriptionid => stripe_subscription.id,:interval=>@interval, :amount=>@amount,:created=>@created).first_or_create
    # current_user.subscription_id = stripe_subscription.id
    # # flash[:notice] = "Successfully created a charge"
    # # redirect_to '/plans'
    # if current_user.save
    #     redirect_to '/skynets/new'
    # else
    #   return
    # end
  end
  def subscription_checkout
    @plan_id = params[:plan_id]
    @plan = Stripe::Plan.retrieve(@plan_id)
    #This should be created on signup.
    customer = Stripe::Customer.create(
        :description => "Customer for test@example.com",
        :source => params[:stripeToken],
        :email => "test@example.com"
      )
    # Save this in your DB and associate with the user;s email
    stripe_subscription = customer.subscriptions.create(:plan => @plan.id)
    @interval =  stripe_subscription.items.data[0].plan.interval
    @amount =  stripe_subscription.items.data[0].plan.amount
    @created =  stripe_subscription.items.data[0].plan.created
    subscription = Subscription.where(:subscriptionid => stripe_subscription.id,:interval=>@interval, :amount=>@amount,:created=>@created).first_or_create
    current_user.subscription_id = stripe_subscription.id
    # flash[:notice] = "Successfully created a charge"
    # redirect_to '/plans'
    if current_user.save
        redirect_to '/skynets/new'
    else
      return
    end    
  end

  private 
  COUPONS = {
    '1233020020073056' => 1,
    '816554411748126' => 1
  }
  def get_discount(code)
  # Normalize user input
    code = code.gsub(/\s+/, '')
    code = code.upcase
    COUPONS[code]
  end

end
