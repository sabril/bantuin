class CandidatesController < ApplicationController
  def create
    @candidate = Candidate.new(params[:candidate])
    if @candidate.save
      flash[:notice] = "Data berhasil dimasukkan"
      render :action => "show"
      #redirect_to @candidate
    else
      render "home/index"
    end
  end
  
  def show
    @candidate = Candidate.find(params[:id])
  end
end
