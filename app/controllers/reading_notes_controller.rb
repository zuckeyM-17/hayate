# frozen_string_literal: true

class ReadingNotesController < BaseController
  def create
    note = Note.create!(body: chapter_note_params[:body], user: current_user)
    reading_note = ReadingNote.create!(
      note_id: note.id,
      reading_id: chapter_note_params[:reading_id]
    )

    redirect_to reading_path(reading_note.reading)
  end

  private

  def chapter_note_params
    params.permit(:reading_id, :body)
  end
end
