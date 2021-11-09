Rails.application.routes.draw do
  
  resources :plateaus do
    resources :rovers
  end
  
end
