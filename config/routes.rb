Rails.application.routes.draw do
  namespace :operators_backoffice do
    get 'welcome/index'
  end
  namespace :pilots_backoffice do
    get 'welcome/index'
  end
  
  devise_for :operators
  devise_for :pilots
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :site do
    get  'welcome/index'
    get  'maneuvers_performed/index'
    get  'next_maneuvers/index'
    #get  'search', to: 'search#questions'
    #get  'subject/:subject_id/:subject', to: 'search#subject' , as: 'search_subject'
    #post 'answer', to: 'answer#question'
  end
   #toda vez que a aplicação for iniciada com seu endereço padrão, será redirecionada para welcome#index
   root to: 'site/welcome#index'
end
