# frozen_string_literal: true

module Tasks
  class NotesController < BaseController
    def index
      @notes = task.notes
    end

    def create
      note = Note.new(user: current_user, body: note_params[:body])
      ActiveRecord::Base.transaction do
        note.save!
        TaskNote.create!(task: task, note: note)
      end

      redirect_to task_notes_path(task)
    end

    private

    def task
      @task ||= current_user.tasks.find(params[:task_id])
    end

    def note_params
      params.permit(:body, :task_id)
    end
  end
end
