class PromotionsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create show active approve]
  before_action :set_promotion, only: %i[show approve active]

  def index
    @promotions = Promotion.all
  end

  def new
    @promotion = Promotion.new
    @products = Product.all
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def create
    @promotion = Promotion.new(params_promotion)
    @promotion.product = Product.find(@promotion.product_id)
    @promotion.prefix = @promotion.product.product_key
    @promotion.creation_user_id = current_user.id

    if @promotion.save
      @promotion.pending!
      flash[:success] = 'Promoção criada com sucesso!'
      redirect_to @promotion
    else
      @products = Product.all
      flash.now[:danger] = 'Preencha os campos corretamente.'
      render :new
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def show
    @promotion = PromotionPresenter.new(@promotion.decorate, current_user)
  end

  def search
    @promotions = Promotion.find_promotion_by_user params[:search]
    render :index
  end

  def status
    @promotions = Promotion.find_promotion_by_status params[:status]
    render :index
  end

  def active
    @promotion.active!
    redirect_to @promotion
  end

  def approve
    @promotion.approved!
    @promotion.create_approval(user_id: current_user.id)
    flash[:success] = 'Promoção aprovada!'
    redirect_to @promotion
  end

  private

  def params_promotion
    params.require(:promotion).permit(:description,
                                      :discount,
                                      :name,
                                      :start_at,
                                      :days,
                                      :product_id,
                                      :coupon_limit)
  end

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end
end
