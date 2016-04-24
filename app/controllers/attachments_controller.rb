class AttachmentsController < ApplicationController
  def download
    attachment = Attachment.find(params[:id])
    authorize attachment
    send_file(
      Paperclip.io_adapters.for(attachment.file).path,      
      type: attachment.file_content_type,
      disposition: :attachment
    )
  end

  def destroy
    @attachment = Attachment.where(id: params[:id], note_id: params[:note_id]).first
    authorize @attachment
    @attachment.destroy

    respond_to do |format|
      format.js
      format.html do
        redirect_to edit_note_path(params[:note_id]), success: 'Attachment deleted'
      end
    end
  end

  private

    def not_authorized
      redirect_to root_path
    end
end