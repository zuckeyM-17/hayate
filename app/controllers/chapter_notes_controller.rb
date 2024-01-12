# frozen_string_literal: true

class ChapterNotesController < ApplicationController
  def create
    p params
    note = Note.create!(body: chapter_note_params[:body])
    chapter_note = ChapterNote.create!(
      note_id: note.id,
      chapter_id: chapter_note_params[:chapter_id]
    )

    redirect_to reading_path(chapter_note.chapter.reading)
  end

  private

  def chapter_note_params
    params.permit(:chapter_id, :body)
  end
end
