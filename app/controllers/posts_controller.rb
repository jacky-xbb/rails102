class PostsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @post = @group.posts.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = @group.posts.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to group_path(@group), notice: "Post created successfully."
    else
      render :new
    end
  end

  private
  def post_params
    params.require(:post).permit(:content)
  end

end
