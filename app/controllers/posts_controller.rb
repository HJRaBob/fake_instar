class PostsController < ApplicationController
    def index
        @posts = Post.all
    end

    def new         
    end

    def create
        post = Post.create(:title => params[:title],:content => params[:content])
        redirect_to "/posts/#{post.id}"
    end

    def read
        @post = Post.find(params[:id])
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        post = Post.find(params[:id])
        post.update(:title => params[:title],:content => params[:content])
        redirect_to "/posts/#{post.id}"
    end

    def delete
        Post.find(params[:id]).delete
        redirect_to "/"
    end
end
