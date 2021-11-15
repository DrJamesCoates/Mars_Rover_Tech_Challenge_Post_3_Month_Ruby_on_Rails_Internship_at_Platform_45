Rails.application.routes.draw do

  root 'static_pages#home'
  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'
  
  resources :plateaus do
    resources :rovers
  end

  get '/move_rover', to: 'rovers#move'
  patch '/update_position', to: 'rovers#update_position'
  
end
