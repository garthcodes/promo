Rails.application.routes.draw do
  resource :promotions, only: [:new, :create, :show]
end
