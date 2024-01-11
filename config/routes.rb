Rails.application.routes.draw do
  #↓管理者側
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  #↓ユーザー側
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #↓ゲストログイン用の設定
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  namespace :admin do #namespaceを使用し/admin/から始まるにURLに指定と、指定したいファイル構成パスに指定
    root to: "homes#top"

    resources :users, only: [:index, :show, :edit, :update]
    resources :shops, only: [:index, :new, :show, :edit, :update]
    resources :reviews, only: [:index, :show, :edit]
    resources :contacts, only: [:index, :show]
  end

  scope module: :public do #public側のroot_pathを使用し「/」とするためscope module:を使用
    root to: "homes#top"

    resources :contacts, only: [:new, :create]
    resources :users, only: [:show, :edit, :update, :check, :withdraw]
    resources :shops, only: [:index]
    resources :comments, only: [:index, :create, :update, :destroy]
    resources :reviews, only: [:idnex, :show, :edit, :update, :create, :destroy, :thanks]
    resources :favorites, only: [:index, :create, :destroy]

    get "about" => "homes#about", as: "about"
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
