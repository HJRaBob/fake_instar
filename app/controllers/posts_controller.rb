class PostsController < ApplicationController
    def index
        @posts = Post.all
    end

    def new         
    end

    def create
        Post.create(:title => params[:title],:content => params[:content])
    end

    def read
        @post = Post.find(params[:id])
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        Post.find(params[:id]).update(:title => params[:title],:content => params[:content])
    end

    def delete
        Post.find(params[:id]).delete
    end
end
