class NotesController < ApplicationController
  respond_to :html, :js	

	def index
		@patient=Patient.find(params[:patient_id])
		@note=Note.new
		@notes=Note.where("patient_id = ?",params[:patient_id]).select("content, created_at").order("created_at ASC")
	end
	def create
		@note = Note.new(noteParams)
		unless @note.save
		flash[:alert]="a problem occured creating the note"
		end
		redirect_to notes_path(patient_id: params[:note][:patient_id])
	end
		
	private
	
	def noteParams
		params.require(:note).permit(:content,:patient_id,:doctor_id)
	end
	
end
