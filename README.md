# 가짜 인스타그램 만들어 보기

1. [REST-Full 하게 구성하기](#Rest-full)
1. [DB 접근 제한](#DB)
1. [CRUD 한줄로 생성](#a-line)

## REST-Full 하게 구성하기 <a name="Rest-full"></a>

### `rout.rb` 구조

``` ruby
root 'posts#index'

get '/posts' => 'posts#index'

get '/posts/new' => 'posts#new'
post'/posts' => 'posts#create'

get '/posts/:id' => 'posts#show'

get '/posts/:id/edit' => 'posts#edit'
put '/posts/:id' => 'posts#update'

delete '/posts/:id' => 'posts#destroy'
```


    간단하게 줄일 수 있다


```ruby
resources :posts
```

### `GET`, `POST`, `PUT` 접근방식

1. `GET`은 가장 기본적인 접근

1. `POST`

    ```erb
    <form action="/posts" method = "POST">
        <input type="hidden" name="authenticity_token" value="<%=form_authenticity_token%>">
    </form>
    ```


    혹은


    ```erb
    <%= form_tag"/posts", method: "post" do %>
        <%= text_field_tag("post[title]") %>
        <%= text_area_tag("post[content]") %>
        <%= submit_tag %>
    <% end %>
    ```

1. `PUT`

    ```erb
    <form action="/posts/<%=@post.id%>" method = "POST">
        <input type="hidden" name="_method" value="put" />
        <input type="hidden" name="authenticity_token" value="<%=form_authenticity_token%>">
    </form>
    ```


    혹은


    ```erb
    <%= form_tag"/posts", method: "put" do %>
        <%= text_field_tag("post[title]"),@post.title %>
        <%= text_area_tag("post[content]"),@post.content %>
        <%= submit_tag %>
    <% end %>
    ```

## DB 접근 제한 <a name="DB"></a>

`posts_controller.rb`

```ruby
before_action :set_post, only: [:show, :edit, :update, :destroy]

private

    def set_post
        @post = Post.find(params[:id])
    end

   def post_params
        params.require(:post).permit(:title,:content)
    end

```

## CRUD 한줄로 생성 <a name="a-line"></a>

```
$ rails g scaffold blog title:string content:text
```

1. `blog.rb`
    ```ruby
    #값이 있을때만 저장
    class Blog < ActiveRecord::Base
        validates :title, presence: true
        validates :content, presence: true
    end
    ```

## Image 업로더 <a name="Img-up"></a>

1. gem `carrierwave` 설치         https://github.com/carrierwaveuploader/carrierwave

1. DB와 controller에 img 저장 추가

1. `new.html.erb`

    ```erb
    <%= form_tag "/posts", method: "post", multipart: true do %>
        <%= text_field_tag("post[title]") %> <br>
        <%= text_area_tag("post[content]") %> <br>
        <%= file_field_tag("post[postimage]") %> <br>
        <%= submit_tag %>
    <% end %>
    ```
1. `show.html.erb`

    ```erb
        <h1><%= @post.title %></h1>
        <br><br>
        <p><%= @post.content %></p>
        <img src="<%=@post.postimage%>">
        <hr>
        <a href="/">홈으로</a>
        <a href="/posts/<%=@post.id%>/edit">수정</a>
    ```