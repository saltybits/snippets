Snippets::Engine.routes.draw do
  resources :snippets, :only => [:edit, :update]

  root :to => 'application#index'
end
