class GroupsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_group, only: %i[show edit update destroy join quit]

  # GET /groups
  def index
    @groups = Group.all
  end

  # GET /groups/1
  def show
    @posts = @group.posts
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      redirect_to groups_path, notice: "Group was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: "Group was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy
    redirect_to groups_url, notice: "Group was successfully destroyed."
  end

  def join
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "Join group successfully."
    else
      flash[:warning] = "You are already a member!"
    end

    redirect_to group_path(@group)
  end

  def quit
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "Quit group successfully."
    else
      flash[:warning] = "You are not a member!"
    end
    redirect_to group_path(@group)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:title, :description)
  end
end
