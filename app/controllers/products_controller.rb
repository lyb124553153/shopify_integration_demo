# frozen_string_literal: true

class ProductsController < AuthenticatedController
  def index
    @products = ShopifyAPI::Product.all(build_params)
    render(json: { products: @products })
  end

  private

  def build_params
    filter_params = { limit: 20 }
    filter_params[:limit] = params[:limit] if params[:limit].present?
    return filter_params unless published_at.present?

    filter_params[:published_at_min] = published_at.beginning_of_day
    filter_params[:published_at_max] = published_at.end_of_day
    filter_params
  end

  def published_at
    params[:published_at].to_date
  rescue StandardError
    nil
  end
end
