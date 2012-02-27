class AppsController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user, :only => [:index,:index_active,:index_finished,
                                         :new,:create,:show,:edit,:finished,:finished_final,:feedback]
  before_filter :correct_user_rating, :only => [:rate]
  def index
    @app = App.find(:all,:joins => :job, :conditions => {:apps => {:user_id => current_user.id},:apps => {:status => nil}})
  end
  
  def index_active
    @app = App.find(:all, :conditions => {:apps => {:user_id => current_user.id},:apps => {:status => 1 }})
  end
  
  def index_finished
    @app = App.find(:all, :conditions => {:apps => {:user_id => current_user.id},:apps => {:status => 2 }})
  end

  def new
    @job = Job.find(params[:job])
    @app = App.new
  end

  def create
    @app = App.new(params[:app])
    if @app.save
      flash.now[:notice] = 'job has been submit'
      redirect_to jobs_path
    else
      render 'new'
    end
  end

  def show
    @app = App.find(:first,:joins => :job, :conditions => {:apps => {:id => params[:id]}})
  end

  def edit
    
  end
  
  def finished
    @app = App.find(params[:id])
    if @app.update_attributes(:finished => 1)
      redirect_to index_active_apps_path
    else
      redirect_to index_active_apps_path
    end
  end
  
  def finished_final
    @job = Job.find(params[:id])
  end
  
  def feedback
    @job = Job.find(params[:id])
    if @job.update_attributes(params[:app])
      @app = App.find(:first, :conditions =>{:apps =>{:job_id => @job},:apps =>{:user_id => current_user.id}})
      @app.update_attributes(:status => 2)
      redirect_to index_active_apps_path
    else
      render 'finished'
    end
  end
  
  def rate
    @app = App.find(params[:id])
    @user = User.find(@app.user_id)
    @app.rate(params[:stars], current_user, params[:dimension])
    @user.rate(params[:stars], current_user,params[:dimension])
    respond_to do |format|
      format.js { render :partial => "jobs/rating" }
    end
  end
  
  def authenticate
    deny_access unless current_user
  end
  
  def correct_user
    if current_user.roles_mask == 1
      redirect_to root_path
    end
  end
  
  def correct_user_rating
    if current_user.roles_mask == 2
      redirect_to root_path
    end
  end
end
