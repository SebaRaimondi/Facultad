Rails.application.routes.draw do
    get 'polite/salute'

    root 'polite#salute'

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end