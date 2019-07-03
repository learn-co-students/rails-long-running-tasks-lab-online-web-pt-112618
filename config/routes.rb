Rails.application.routes.draw do
  resources :artists, :songs
  post 'songs/upload', to: 'songs#upload'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
