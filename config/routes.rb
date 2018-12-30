Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    get root 'page#index'

    get 'no_access_right', controller: :page, action: :no_access_right
    match 'login', controller: :page, action: :login, via: [:get, :post]
    get 'logout', controller: :page, action: :logout
    get   :no_access_rights, controller: :page

    # 管理者
    resources :admin_users

    # コンテンツ
    resources :contents

    # カテゴリ
    resources :categories

    # ジャンル
    resources :genres

    # 価格帯
    resources :price_ranges

    # 設定
    resources :preferences
  end
end
