# frozen_string_literal: true

class ReviewToolsController < ApplicationController
  def show
    @posts = Sizume::Posts.new.call(created_after: 1.week.ago)
    @posts = @posts.sort_by(&:createdAt).reverse.select { |p| p.visibility == 'ANYONE' }
  end
end
