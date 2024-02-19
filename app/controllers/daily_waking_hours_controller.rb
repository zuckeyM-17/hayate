# frozen_string_literal: true

class DailyWakingHoursController < ApplicationController
  def update
    wh = DailyWakingHour.find(update_params[:id])
    wh.update!(upped_at: update_params[:upped_at], turned_in_at: update_params[:turned_in_at])

    redirect_to root_path(last_week: update_params[:last_week])
  end

  private

  def update_params
    params.permit(:id, :upped_at, :turned_in_at, :last_week)
  end
end
