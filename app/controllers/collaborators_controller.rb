class CollaboratorsController < ApplicationController
  def new
    @wiki = Wiki.find(params[:id])
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.build(collaborator_params)
    @collaborators = User.all
    @new_collaborator = Collaborator.new
    current_collaborators = @wiki.users
    @user = User.find_by(email: params[:collaborator][:user])

    if @collaborator.save
      flash[:notice] = "Collaborator added."
    else
      flash[:alert] = "Error occured. Please try again."
    end
    redirect_to edit_wiki_path(@wiki)
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @collaborator_user = User.find(@collaborator.user_id)

    if @collaborator.destroy
      flash[:notice] = "#{@collaborator_user.email} was removed as a collaborator."
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