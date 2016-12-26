BigGollum::Application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  constraints(Constraints::NoUser.new) do
    get '/', to: "first_accounts#new"
    resource :first_account
  end

  constraints(Constraints::HasUsers.new) do
    root to: 'wikis#index'
    match "/wiki/:wiki(/*other)", to: WikiMounter, anchor: true, as: "mounted_wiki", via: [:get, :post]
    resources :wikis, :only => [:index, :create, :new, :edit, :update, :destroy]
    resource :settings, only: [:show, :edit, :update]
    resources :invite_users
  end
end
