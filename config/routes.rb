Investitions::Application.routes.draw do
  match 'mapping/index' => 'mapping#index'
  match 'mapping/entities' => 'mapping#entities'
  match 'mapping/load' => 'mapping#load'

  resources :subjects
end
