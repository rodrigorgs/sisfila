Rails.application.routes.draw do
  resources :mesas
  resources :rodadas
  resources :vagas
  resources :alunos

  root to: "tela#home"
  get "/tela", to: "tela#index", as: :tela
  post "/tela/inscrever", to: "tela#inscrever", as: :tela_inscrever

  post "/mesas/:id/escolher", to: "mesas#escolher", as: :mesa_escolher

  put "/rodadas/:id/proximo", to: "rodadas#proximo", as: :rodadas_proximo
  put "/rodadas/:id/anterior", to: "rodadas#anterior", as: :rodadas_anterior
  put "/rodadas/:id/chama-novamente", to: "rodadas#chama_novamente", as: :rodadas_chama_novamente

  get "/posicao/:matricula", to: "tela#posicao_aluno"

  devise_for :users, controllers: { registrations: "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
