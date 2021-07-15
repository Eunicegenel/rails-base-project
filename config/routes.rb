Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  
  devise_for :users, controllers: {
    confirmations: 'confirmations'
  }
  
  root to: 'home#index'
  
  post '/items/comment/:id' => 'items#comment', as: 'items_comment'
  put '/items/:id' => 'items#update_comment', as: 'update_comment'
  delete '/items/:id' => 'items#delete_comment', as: 'delete_comment'

  resources :items do 
    resources :conversations
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
