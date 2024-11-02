# frozen_string_literal: true

class NotesController < ApplicationController
  def create
    Note.create!(note_params.merge(user: current_user))

    redirect_to root_path
  end

  private

  def note_params
    params.permit(:body)
  end
end
