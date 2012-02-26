class JobsController < ApplicationController
  before_filter :authenticate, :only => [:new, :edit, :view_jobs, :view_apps ]
  before_filter :correct_user, :only => [:new, :edit, :view_jobs, :view_apps ]
  def index
    @job = Job.all
  end
  
  def new
    @location = Location.all
    @job = Job.new
  end
  
  def create
    @job = Job.new(params[:job])
    if @job.save
      redirect_to job_path
      flash[:success] = "jobs had been add"
    else
      render 'new'
    end
  end
  
  def show
    @job = Job.find(:first, :joins => :user, :conditions => {:jobs => {:id => params[:id]}})
    if current_user
      @app = App.find_by_user_id(current_user.id)
    end
  end
  
  def edit
    @job = Job.find(params[:id])
    @location = Location.all
  end
  
  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(params[:job])
      redirect_to view_jobs_jobs_path
    else
      render 'edit'
    end  
  end
  
  def view_jobs
    @job = Job.all(:conditions => {:jobs => {:user_id => current_user.id}})
  end
  
  def view_apps
    @app = App.find(:all,:joins => :user, :conditions => {:apps =>{:job_id => params[:job]}})
    @job = Job.find(params[:job])
  end
  
  def authenticate
    deny_access unless current_user
  end
  
  def actived
    @app = App.find(params[:id])
    if @app.update_attributes(:status => 1)
      @job = Job.find(@app.job_id)
      @job.update_attributes(:status => 1)
      redirect_to view_jobs_jobs_path
    else
      render 'view_apps'
    end
  end
  
  def finished
    @app = App.find(:first, :conditions => {:apps => {:job_id => params[:id]},:apps => {:status => 1},:apps => {:finished => 1}})
  end
  
  def rate
    @job = Job.find(params[:id])
    @job.rate(params[:stars], current_user, params[:dimension])
    respond_to do |format|
      format.js { render :partial => "rating" }
    end
  end
  
  def correct_user
    if current_user.roles_mask == 2
      redirect_to root_path
    end
  end
end
