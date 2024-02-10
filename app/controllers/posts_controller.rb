# frozen_string_literal: true

class PostsController < ApplicationController
  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1/edit
  def edit; end

  def search_post
    @posts = Post.where('lower(content) like ?', "%#{params[:content].downcase}%")
    puts @posts
    render 'home/index'
  end

  # POST /posts
  def create
    @post = Post.new(post_params) do |post|
      post.user = Current.user
    end

    if @post.save
      redirect_to root_path, notice: 'Post uploaded successfully'
    else
      redirect_to root_path, alert: 'Post could not be uploaded'
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def post_params
    params.require(:post).permit(:attachment, :content, :user_id)
  end
end
