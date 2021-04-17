Rails.application.routes.draw do
  resources :colegiados
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :filas
  resources :mesas
  resources :rodadas
  resources :vagas
  resources :alunos

  root to: "tela#home"
  
  # # Used by e2e tests (in another project):
  # get "/reset", to: "tela#reset", as: :reset
  # get "/cria-cenario", to: "tela#cria_cenario", as: :cria_cenario

  get "/tela", to: "tela#index", as: :tela
  get "/tela/dados", to: "tela#dados", as: :tela_dados
  post "/tela/inscrever", to: "tela#inscrever", as: :tela_inscrever

  post "/mesas/:id/escolher", to: "mesas#escolher", as: :mesa_escolher
  post "/mesas/remover-selecao", to: "mesas#remover_selecao", as: :mesa_remover_selecao

  put "/filas/:id/proximo", to: "filas#proximo", as: :filas_proximo
  put "/filas/:id/anterior", to: "filas#anterior", as: :filas_anterior
  put "/filas/:id/esvazia_mesa", to: "filas#esvazia_mesa", as: :esvazia_mesa
  get "/filas/:id/shuffle", to: "filas#shuffle", as: :shuffle

  put "/colegiados/:id/proximo", to: "colegiados#proximo", as: :colegiados_proximo
  put "/colegiados/:id/anterior", to: "colegiados#anterior", as: :colegiados_anterior
  put "/colegiados/:id/esvazia_mesa", to: "colegiados#esvazia_mesa", as: :colegiado_esvazia_mesa

  get "/posicao/:matricula", to: "tela#posicao_aluno"

  get "/importar", to: "importer#index"
  post "/importar", to: "importer#import"

  get "/inscricao", to: "inscricao#index"
  post "/inscricao", to: "inscricao#inscrever"

  devise_for :users, controllers: { registrations: "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
