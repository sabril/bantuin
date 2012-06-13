class MessagesController < ApplicationController
  before_filter :authenticate
  def index
    message = User.find(current_user.id)
    @message = message.received_messages
  end

  def index_outbox
    message = User.find(current_user.id)
    @message = message.sent_messages
  end
  
  def new
    @message = Message.new
    @user = User.find(params[:user])
    if params[:reply] != nil
      @message_reply = Message.read_message(params[:reply],current_user.id).subject
    else
      @message_reply = nil
    end
  end

  def create
    @message = Message.new(params[:message])
    if @message.save
      redirect_to view_jobs_jobs_path
    else
      render 'new'
    end
  end

  def show
    @message = Message.read_message(params[:id],current_user.id)
  end

  def delete
  end
  
  def authenticate
    deny_access unless current_user
  end
end
