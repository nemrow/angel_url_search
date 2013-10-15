VisibleCodeChallenge::Application.routes.draw do
  root :to => 'welcome#index'
  resources :startups
end
