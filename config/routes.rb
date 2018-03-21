Rails.application.routes.draw do
  resource :promotions, only: [:new, :create, :show]
  root 'promotions#new'
end
