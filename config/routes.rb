Rails.application.routes.draw do
  resources :rodadas
  resources :vagas
  resources :alunos

  get "/tela", to: "tela#index", as: :tela
  post "/tela/inscrever", to: "tela#inscrever", as: :tela_inscrever

  put "/rodadas/:id/proximo", to: "rodadas#proximo", as: :rodadas_proximo
  put "/rodadas/:id/anterior", to: "rodadas#anterior", as: :rodadas_anterior

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
