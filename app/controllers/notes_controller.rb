# frozen_string_literal: true

class NotesController < ApplicationController
  def create
    note = Note.create!(note_params)

    redirect_to root_path
  end

  private

  def note_params
    params.permit(:body)
  end
end
