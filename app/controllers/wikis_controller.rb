class WikisController < ApplicationController
  before_action :authenticate_user!

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])

  end

  def new
    @wiki = Wiki.new 
  end

  def edit
    @wiki = Wiki.find(params[:id])
    #@collaborator = Collaborator.find(params[:user_email])
    @collaborators = @wiki.collaborators.all
  end

  def create
    @wiki = Wiki.new
    @wiki.user = current_user
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    if @wiki.user.standard_member?
      @wiki.private = false 
    end

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki 
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new 
    end
  end

  def update 
    @wiki = Wiki.find(params[:id])
    @wiki.user = current_user
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki 
    else
      flash.now[:alert] = "There was an error updating this wiki. Please try again."
      render :edit 
    end
  end

  def destroy 
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "Your wiki, \"#{@wiki.title}\", was deleted successfully."
      redirect_to wikis_path 
    else
      flash.now[:alert] = "There was an error deleting this wiki. Please try again."
      render :show 
    end
  end
  
end
