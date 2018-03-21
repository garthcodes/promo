class PromotionsController < ApplicationController

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    @promotion.assigned = true if promotion_params[:user_ids].present?
    if @promotion.save
      redirect_to promotions_path(@promotion), notice: 'Promotion was successfully created.'
    else
      render :new
    end
  end

  def show
    @promotion = Promotion.find(params[:format])
  end

  private

  def promotion_params
    params.require(:promotion).permit(:start_date, :end_date, :discount,
                                      :user_message, :internal_message,
                                      :code, :user_ids)
  end
end