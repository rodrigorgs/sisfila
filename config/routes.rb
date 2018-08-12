Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :filas
  resources :mesas
  resources :rodadas
  resources :vagas
  resources :alunos

  root to: "tela#home"
  get "/tela", to: "tela#index", as: :tela
  get "/tela/dados", to: "tela#dados", as: :tela_dados
  post "/tela/inscrever", to: "tela#inscrever", as: :tela_inscrever

  post "/mesas/:id/escolher", to: "mesas#escolher", as: :mesa_escolher

  put "/filas/:id/proximo", to: "filas#proximo", as: :filas_proximo
  put "/filas/:id/anterior", to: "filas#anterior", as: :filas_anterior
  put "/filas/:id/esvazia_mesa", to: "filas#esvazia_mesa", as: :esvazia_mesa

  get "/posicao/:matricula", to: "tela#posicao_aluno"

  devise_for :users, controllers: { registrations: "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
