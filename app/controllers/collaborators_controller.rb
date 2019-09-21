class CollaboratorsController < ApplicationController
  
  def index
    @wiki = Wiki.find(params[:wiki_id])
    @collaborators = @wiki.collaborators.all
  end
  
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find_by_email(params[:collaborator][:user])
    @collaborator = Collaborator.new

    if @user == nil
      flash[:error] = "That user could not be found."
      return redirect_to edit_wiki_path(@wiki)
    else
      @collaborator.wiki = @wiki
      @collaborator.user = @user 
    end

    if @collaborator.save
      flash[:notice] = "Collaborator added."
      return redirect_to @wiki
    else
      flash[:alert] = "Error occured. Please try again."
      return redirect_to @wiki
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @wiki = @collaborator.wiki

    if @collaborator.destroy
      flash[:notice] = "Collaborator has been removed."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:alert] = "There was an error removing this collaborator. Please try again."
      redirect_to edit_wiki_path(@wiki)
    end
  end

  private

  def collaborator_params
    params.require(:collaborator).permit(:wiki_id, :user_id)
  end
end