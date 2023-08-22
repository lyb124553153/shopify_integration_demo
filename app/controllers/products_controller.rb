# frozen_string_literal: true

class ProductsController < AuthenticatedController
  before_action :build_params, only: [:index]
  def index
    @products = ShopifyAPI::Product.all(filter_params)
    render(json: { products: @products })
  end

  private

  def build_params
    return unless params[:published_at].present?

    published_date = params[:published_at].to_date

    filter_params[:published_at_min] = published_date.beginning_of_day
    filter_params[:published_at_max] = published_date.end_of_day
  end

  def filter_params
    {
      limit: 20
    }
  end

  def published_date; end
end
