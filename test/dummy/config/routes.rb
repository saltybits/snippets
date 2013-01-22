Rails.application.routes.draw do
  mount Snippets::Engine => "/admin"
end
