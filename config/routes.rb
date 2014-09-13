Rails.application.routes.draw do
  root 'domain_patterns#new'
  match 'results', to: 'domain_patterns#show', via: :post
end
