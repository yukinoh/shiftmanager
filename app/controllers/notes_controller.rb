class NotesController < ApplicationController
  
  def create
    @note = Note.new(note_params)
      
    if @note.save
      redirect_to calendar_index_path
    else
      #要エラー処理
      redirect_to calendar_index_path
    end
    
  end
  
  def delete
    n = Note.find(params[:id])
    n.destroy
    redirect_to calendar_index_path
  end
  
  private
  
  def note_params
    params.require(:note).permit(:created_for, :content)
  end

end
