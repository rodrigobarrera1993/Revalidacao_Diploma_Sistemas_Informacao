Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   #toda vez que a aplicação for iniciada com seu endereço padrão, será redirecionada para welcome#index
   root to: 'site/welcome#index'
end
