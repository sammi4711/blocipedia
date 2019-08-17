class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])

    if current_user.role == 'standard_member' && @wiki.private == true 
      @wiki.title = "[Private Wiki]"
      @wiki.body = "[You are not authorized to view the contents of this wiki. Upgrade to a Premium Membership to have access to private wikis.]"
    end
  end

  def new
    @wiki = Wiki.new 
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def create
    @wiki = Wiki.new
    @wiki.user = current_user
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]


=begin
    if current_user.role == 'standard_member'
      @wiki.update_attribute(:private, false)
    else
      @wiki.update_attribute(:private, true)
    end
=end

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
