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

    resources :users, only: [:index, :show, :edit, :update]
    resources :shops, only: [:new, :index, :create, :show, :edit, :update]
    resources :reviews, only: [:index, :show, :edit, :destroy]
    resources :contacts, only: [:index, :show]
    resources :tagsersches, only: [:index]
  end

  scope module: :public do #public側のroot_pathを使用し「/」とするためscope module:を使用
    root to: "homes#top"
    get "contacts/thanks" => "contacts#thanks"
    get "reviews/thanks" => "reviews#thanks"
    get "tagsearches/search" => "tagsearches#search"

    resources :contacts, only: [:new, :create]
    resources :users, only: [:show, :edit, :update] do
      member do
        get :favorites
      end
    end
    resources :shops, only: [:index, :show]
    resources :favorites, only: [:index]
    resources :reviews, only: [:new, :index, :show, :edit, :update, :create, :destroy, :thanks] do
      resource :favorites, only: [:create, :destroy]
    end
    resources :comments, only: [:new, :index, :create, :update, :destroy]

    # URLをカスタマイズするために下記のような記述をしました。
    get "about" => "homes#about", as: "about"
    get "users/mypage" => "users#show"
    get "users/information/edit" => "users#edit"
    patch "users/information" => "users#update"
    get "users/check" => "users#check"
    patch "users/withdraw" => "users#withdraw"
  end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
