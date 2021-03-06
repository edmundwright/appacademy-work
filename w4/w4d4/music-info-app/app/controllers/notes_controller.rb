class NotesController < ApplicationController
  skip_before_action :ensure_admin

  def create
    note = Note.new(note_params.merge({user_id: current_user.id}))

    if note.save
      flash[:notice] = "Thanks for adding a new note!"
    else
      flash[:errors] = note.errors.full_messages
    end

    redirect_to track_url(note.track)
  end

  def destroy
    note = Note.find(params[:id])
    if note.user == current_user || current_user.admin?
      note.destroy!
      redirect_to track_url(note.track)
    else
      render text: "NOOOOOO", status: :forbidden
    end
  end

  private

  def note_params
    params.require(:note).permit(:body, :track_id)
  end
end
