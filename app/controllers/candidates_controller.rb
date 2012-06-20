class CandidatesController < ApplicationController
  
  def create
    @candidate = Candidate.new(params[:candidate])
    # session[:candidate_params].deep_merge!(params[:candidate]) if params[:candidate]
    # @candidate = Candidate.new(session[:candidate_params])
    @candidate.current_step = session[:candidate_step]
    if params[:back_button]
      @candidate.previous_step
    else  
      if @candidate.save
        @candidate.next_step
      end
    end
    @candidate.status = @candidate.current_step
    @candidate.save
    session[:candidate_step] = @candidate.current_step
    render :new
    
    # if @candidate.save
    #   flash[:notice] = "Data berhasil dimasukkan"
    #   render :action => "show"
    #   #redirect_to @candidate
    # else
    #   render "home/index"
    # end
  end
  
  def update
    @candidate = Candidate.find(params[:id])
    @candidate.current_step = session[:candidate_step]
    if params[:back_button]
      @candidate.previous_step
    else  
      if @candidate.update_attributes(params[:candidate])
        @candidate.next_step
      end
    end
    @candidate.status = @candidate.current_step
    puts @candidate.inspect
    @candidate.save
    session[:candidate_step] = @candidate.current_step
    render :new
  end
  
  def show
    @candidate = Candidate.find(params[:id])
  end
  
  def new
    session[:candidate_params] ||= {}
    @candidate = Candidate.new
  end
end
