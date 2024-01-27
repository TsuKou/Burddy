Rails.application.routes.draw do
  # --ここから--管理者側-----
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # --ここまで---------------

  # --ここから--ユーザー側-----
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # --ここまで---------------

  # --ここから--ゲストログイン用の設定
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  # --ここまで---------------

  namespace :admin do #namespaceを使用し/admin/から始まるにURLに指定と、指定したいファイル構成パスに指定
    root to: "homes#top"
    get "tagsearches/search" => "tagsearches#search"
    get "reviews/:id/shop_index" => "reviews#shop_index", as: "shop_index"

    resources :users, only: [:index, :show, :edit, :update] do
      member do # usersとfavoritesの間に[id]を付けたいので[member]で指定
        get :favorites
      end
    end
    resources :shops, only: [:new, :index, :create, :show, :edit, :update]
    resources :reviews, only: [:index, :show, :create, :edit, :destroy]
    resources :contacts, only: [:index, :show]
    resources :tagsearches, only: [:index]
    resources :comments, only: [:edit]
  end

  scope module: :public do #public側のroot_pathを使用し「/」とするためscope module:を使用
    root to: "homes#top"
    get "about" => "homes#about", as: "about"
    # user
    get "users/check" => "users#check"
    get "users/:id/mypage" => "users#show", as: "mypage"
    get "users/information/edit" => "users#edit"
    patch "users/information" => "users#update"
    patch "users/withdraw" => "users#withdraw"
    # contact
    get "contacts/thanks" => "contacts#thanks", as: "contact_thanks"
    # review
    get "review/:id/user_show" => "reviews#user_show", as: "user_review"
    get "reviews/thanks" => "reviews#thanks"
    # tagsearch
    get "tagsearches/search" => "tagsearches#search"
    # comment
    get "comments/:id/user_index" => "comments#user_index", as: "user_index"



    resources :contacts, only: [:new, :create, :index, :show]
    resources :users, only: [:show, :edit, :update] do
      member do
        get :favorites
      end
    end
    resources :shops, only: [:index, :show]
    resources :favorites, only: [:index]
    resources :comments, only: [:index]
    resources :reviews, only: [:new, :index, :show, :edit, :update, :create, :destroy, :thanks] do
      resource :favorites, only: [:create, :destroy]
      resource :comments, only: [:new, :create, :edit, :update, :destroy]
    end

    resources :tagsearches, only: [:index]

    # URLをカスタマイズするために下記のような記述をしました。

  end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
