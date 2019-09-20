class CollaboratorsController < ApplicationController
  
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.where(email: params[:email]).take
    @collaborator = Collaborator.new

    if @user == nil
      flash[:error] = "That user could not be found."
      redirect_to edit_wiki_path(@wiki)
    else
      @collaborator.wiki = @wiki
      @collaborator.user = @user 
    end

    if @collaborator.save
      flash[:notice] = "Collaborator added."
      redirect_to @wiki
    else
      flash[:alert] = "Error occured. Please try again."
      redirect_to @wiki
    end
  end

=begin
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
=end 

  private

  def collaborator_params
    params.require(:collaborator).permit(:wiki_id, :user_id)
  end
end