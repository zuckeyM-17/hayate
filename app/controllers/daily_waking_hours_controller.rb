# frozen_string_literal: true

class DailyWakingHoursController < ApplicationController
  def update
    wh = DailyWakingHour.find(params[:id])
    date = wh.daily_task_set.date
    upped_at, turned_in_at = parse_time(date, update_params[:upped_at], update_params[:turned_in_at])
    wh.update!(upped_at:, turned_in_at:)

    redirect_to root_path(last_week: update_params[:last_week])
  end

  private

  def update_params
    params.require(:daily_waking_hour).permit(:upped_at, :turned_in_at, :last_week)
  end

  def parse_time(date, upped_at, turned_in_at)
    upped_at_datetime = Time.zone.parse("#{date} #{upped_at}") if upped_at.present?
    # 就寝時間が午前0時を過ぎていたら翌日の日付にする
    turned_in_at_datetime = if turned_in_at.present?
                              datetime = Time.zone.parse("#{date} #{turned_in_at}")
                              datetime += 1.day if datetime.hour < 12
                              datetime
                            end
    [upped_at_datetime, turned_in_at_datetime]
  end
end
