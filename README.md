# 가짜 인스타그램 만들어 보기

## REST-Full 하게 구성하기

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
    <%= text_field_tag("title") %>
    <%= text_area_tag("content") %>
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
    <%= text_field_tag("title") %>
    <%= text_area_tag("content") %>
    <%= submit_tag %>
<% end %>
```

### DB 접근 제한

`posts_controller.rb`

```ruby
before_action :set_post, only: [:show, :edit, :update, :destroy]

private

    def set_post
        @post = Post.find(params[:id])
    end
```