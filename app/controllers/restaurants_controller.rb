class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurant_create_params)
    if @restaurant.persisted?
      redirect_to(@restaurant)
    else
      render :new
    end
  end

  def edit
    @restaurant = fetch_and_authorize_restaurant
  end

  def update
    @restaurant = fetch_and_authorize_restaurant
    if @restaurant.update_attributes(restaurant_params)
      redirect_to(@restaurant)
    else
      render :edit
    end
  end

  def show
    @restaurant = fetch_restaurant_by_id
  end

  def destroy
    @restaurant = fetch_and_authorize_restaurant
    @restaurant.destroy if @restaurant
    redirect_to restaurants_path 
  end

  private
  def fetch_and_authorize_restaurant
    restaurant = fetch_restaurant_by_id
    if restaurant.is_owner?(current_owner)
      restaurant
    else
      flash[:error] = "Unauthorized"
      redirect_to(restaurant)
    end
  end

  def fetch_restaurant_by_id
    Restaurant.find(params.fetch(:id))
  end

  def restaurant_params
    params.require(:restaurant).permit(
      :name,
      :description,
      :address_1,
      :address_2,
      :phonne
      )
  end

  def restaurant_create_params
    restaurant_params.merge(owner: current_owner)
  end
end
