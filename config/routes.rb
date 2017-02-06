Rails.application.routes.draw do
  root 'static_pages#home'

  resources :notes do
    resources :attachments, only: [:destroy] do
      get 'download', on: :member
    end
  end

  scope controller: :users do
    get  'signup'       => :new
    post 'signup'       => :create
    get  'account'      => :show, as: 'account'
    get  'account/edit' => :edit, as: 'account_edit'
    patch 'account'     => :update
  end

  scope controller: :password_changes do
    get  'account/change-password' => :new,    as: 'new_password_change'
    post 'account/change-password' => :create, as: 'password_changes'
  end

  scope controller: :sessions do
    get    'login'  => :new
    post   'login'  => :create
    delete 'logout' => :destroy
  end
end
