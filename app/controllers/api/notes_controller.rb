# frozen_string_literal: true

module Api
  class NotesController < Api::BaseController
    protect_from_forgery

    def create
      authenticate!

      note = Note.create!(note_params.merge(user: current_user))
      render json: { note: { id: note.id } }
    end

    private

    def note_params
      params.require(:note).permit(:body)
    end
  end
end
