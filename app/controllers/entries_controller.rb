# frozen_string_literal: true

class EntriesController < ApplicationController
  def index
    @entries = current_user.entries.includes(:feed).order(created_at: :desc).page(params[:page])
  end
end
