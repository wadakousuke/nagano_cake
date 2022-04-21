Rails.application.routes.draw do
  namespace :admin do
    resources :order_details, only:[:update]
    resources :orders, only:[:update, :show, :index]
    resources :customers, except:[:destroy, :create]
    resources :genres, except:[:destroy, :new, :show]
    resources :items, except:[:destroy]
   root to:'homes#top'
  end

  scope module: :public do
    resources :addresses, except:[:new, :show]
    resources :orders, except:[:destroy, :update, :edit ]
    post 'order/confirm' => "orders#confirm", as:"confirm"
    get 'order/complete' => "orders#complete"
    resources :cart_items, except:[:new, :show, :edit]
    delete 'cart_items/empty' => "cart_items#empty", as:"empty"
    resources :customers, only:[:update, :edit]
    get 'customers/my_page' => "customers#my_page", as:"my_page"
    get 'customers/unsubscribe' => "customers#unsubscribe", as:"unsubscribe"
    patch 'customers/withdraw' => "customers#withdraw", as:"withdraw"
    resources :items, only:[:index, :show]
    root to:'homes#top'
    get 'homes/about' => "homes#about", as:"about"
  end

 devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
 }
  devise_for :admin, controllers: {
  sessions: "admin/sessions"
 }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
