# frozen_string_literal: true

class ReviewToolsController < ApplicationController
  def show
    @posts = Sizume::Posts.new.call(created_after: Time.zone.now.beginning_of_week)
    @posts = @posts.sort_by(&:createdAt).reverse.select { |p| p.visibility == 'ANYONE' }
  end
end
