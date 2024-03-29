# frozen_string_literal: true

class DailyTaskItemsController < ApplicationController
  def index
    @daily_task_items = DailyTaskItem.enabled
    @daily_task_item = DailyTaskItem.new
  end

  def create
    DailyTaskItem.create!(daily_task_item_params)

    redirect_to daily_task_items_path
  end

  def destroy
    daily_task_item = DailyTaskItem.find(params[:id])
    daily_task_item.disable!

    redirect_to daily_task_items_path
  end

  private

  def daily_task_item_params
    params.require(:daily_task_item).permit(:name)
  end
end
