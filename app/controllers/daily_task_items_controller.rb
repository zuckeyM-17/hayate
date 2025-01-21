# frozen_string_literal: true

class DailyTaskItemsController < BaseController
  def index
    @daily_task_items = current_user.daily_task_items.enabled
    @daily_task_item = DailyTaskItem.new
  end

  def create
    DailyTaskItem.create!(daily_task_item_params.merge(user: current_user))

    redirect_to daily_task_items_path
  end

  def destroy
    daily_task_item = current_user.daily_task_items.find(params[:id])
    daily_task_item.disable!

    redirect_to daily_task_items_path
  end

  private

  def daily_task_item_params
    params.expect(daily_task_item: [:name])
  end
end
