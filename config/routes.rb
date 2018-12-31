Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Ckeditor::Engine => '/ckeditor'
  namespace :admin do
    get root 'page#index'

    get 'no_access_right', controller: :page, action: :no_access_right
    match 'login', controller: :page, action: :login, via: [:get, :post]
    get 'logout', controller: :page, action: :logout
    get   :no_access_rights, controller: :page

    # 管理者
    resources :admin_users

    # コンテンツ
    resources :contents do
      match :zip_search, via: [:get, :post, :patch], on: :collection
      get :mod_category, on: :collection
    end

    # カテゴリ
    resources :categories do
      match :sort, via: [:get, :post], on: :collection
    end

    # ジャンル
    resources :genres do
      match :sort, via: [:get, :post], on: :collection
    end

    # 価格帯
    resources :price_ranges do
      match :sort, via: [:get, :post], on: :collection
    end

    # 好み
    resources :preferences do
      match :sort, via: [:get, :post], on: :collection
    end

    get  'system_configs', controller: :system_configs, to: "system_configs#index"
    put  'system_configs', controller: :system_configs, to: "system_configs#update"
    post 'system_configs', controller: :system_configs, to: "system_configs#import_zip_list"
  end

  scope module: 'front' do
    root 'page#index'
  end
end
