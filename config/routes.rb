# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html


#match :repissues, :to =>"Repissues_Controller#index", :mode => :exceed
match "repissues" => "Repissues#index", :via => [:post, :get]
resources :repissues

#match 'repissues', :to => "RepissuesController#index"
#match 'redmine/repissues', :to => "RepissuesController#index"



