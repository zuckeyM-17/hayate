# frozen_string_literal: true

class NotesController < BaseController
  def create
    Note.create!(note_params.merge(user: current_user))

    redirect_to root_path
  end

  def destroy
    @note = Note.find(params[:id])
    @task = @note.task
    @note.destroy
  end

  private

  def note_params
    params.require(:note).permit(:body)
  end
end
