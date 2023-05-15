Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
root "labs#index"

get '/change_page' => 'students#change_page'
get '/change_scores_page' => 'scores#change_page'
get '/change_score_selection' => 'scores#change_selection'

resources :labs
resources :students
resources :scores

end
