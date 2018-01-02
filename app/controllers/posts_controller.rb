class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    
    def index
        @posts = Post.all
    end

    def new         
    end

    def create
        post = Post.create(post_params)
        redirect_to "/posts/#{post.id}"
    end

    def show
        #@post = Post.find(params[:id])
    end

    def edit
        #@post = Post.find(params[:id])
    end

    def update
        #post = Post.find(params[:id])
        @post.update(post_params)
        redirect_to "/posts/#{@post.id}"
    end

    def destroy
        #Post.find(params[:id]).delete
        @post.delete
        redirect_to "/"
    end

    private

    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:title,:content)
    end
end
