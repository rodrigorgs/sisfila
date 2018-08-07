Rails.application.routes.draw do
  resources :rodadas
  resources :vagas
  resources :alunos

  # root "tela#show", page: "home"
  resources :tela

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
