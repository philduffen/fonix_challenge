Rails.application.routes.draw do
  root 'challenges#index'
  get 'challenges/index'
  post '/challenges' => 'challenges#mobile_send'
  get  '/challenges/code_confirm' => 'challenges#code_confirm'
  post '/challenges/code_check' => 'challenges#code_check'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
