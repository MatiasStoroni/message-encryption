Rails.application.routes.draw do

  resources :messages do
    put "/encriptar", to: "messages#encrypt"
  end


end
