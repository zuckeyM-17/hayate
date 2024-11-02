# frozen_string_literal: true

class ReviewToolsController < ApplicationController
  def show
    @posts = Sizume::Posts.new.call(created_after: 7.days.ago)
    @posts = @posts.sort_by(&:createdAt).reverse.select { |p| p.visibility == 'ANYONE' }

    @readings = current_user.readings.in_progress
  end
end
