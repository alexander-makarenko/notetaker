class NotesController < ApplicationController
  def index
    authorize Note
    @notes = current_user.notes.order(updated_at: :desc).paginate(page: params[:page])
  end

  def show
    @note = Note.find(params[:id])
    authorize @note
    @note.description = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@note.description)
  end

  def new
    authorize Note
    @note = Note.new
  end

  def create
    authorize Note
    @note = current_user.notes.build(note_params)
    if @note.save
      redirect_to notes_path
    else
      render :new
    end
  end

  def edit
    @note = Note.find(params[:id])
    authorize @note
  end

  def update
    @note = Note.find(params[:id])
    authorize @note
    if @note.update_attributes(note_params)
      redirect_to notes_path
    else
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    authorize @note
    @note.destroy

    respond_to do |format|
      format.js
      format.html do
        redirect_to notes_path, success: 'Note deleted'
      end
    end    
  end

  private

    def note_params
      params.require(:note).permit(:title, :description, attachments: [])
    end

    def not_authorized
      ['index', 'new', 'create'].include?(action_name) ? super : redirect_to(root_path)
    end
end