Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  namespace :crew do

    devise_for :admins,
    controllers:{
      sessions: "crew/admins/sessions",
      passwords: "crew/admins/passwords",
      confirmations: 'crew/admins/confirmations'
    },
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      password: 'secret',
      unlock: 'unblock'
    }
    devise_scope :admin do
      authenticated  do
        resources :users
        resources :lots
        resources :admins
        resources :hotels, only: [:edit,:update, :index] do
          get 'users'
        end
        resources :rooms
        resources :events
        get '/events_pending' => 'events#pending'


        #troca de vaga
        post '/change_vacancies/processar'
        get '/change_vacancies/index'
        # Events
        delete '/events/:id/remove/:user_id' => 'events#remove_user', as: :remove_event_user

        get '/qualified_users' => 'users#qualified', as: :users_qualified
        get '/disqualified_users' => 'users#disqualified', as: :users_disqualified
        get '/waiting_list' => 'users#waiting_list', as: :users_waiting_list
        get '/pays_list' => 'users#pays_list', as: :users_pays_list
        get '/certificates' => 'users#certificate', as: :users_certificate_list
        post '/certificates/update' => 'users#certificate_update', as: :users_certificate_update
        get '/certificates/upload' => 'users#certificate_upload', as: :users_certificate_upload

        #USUARIO ADMIN
        patch 'move_user_to_lot/:user_id/:lot_id' => 'admins_methods#move_user_to_lot', as: :move_user_to_lot
        patch 'change_users/:user_id/:user_2_email' => 'admins_methods#change_users', as: :change_users_position
        patch 'disqualify/:id' => 'admins_methods#disqualify_user', as: :disqualify_user
        patch 'move_first_user_to_lot/:lot_id' => 'admins_methods#move_first_user_to_lot', as: :move_first_user_to_lot

        #PAYMENTS
        patch 'change_payment_status/:id/:status' => 'admins_methods#change_payment_status', as: :change_payment_status
        patch 'set_billet_portion_paid/:id/:portion_paid' => 'admins_methods#billet_portion_paid', as: :set_billet_portion_paid
        patch 'remove_payment_method/:id' => 'admins_methods#remove_payment_method', as: :change_payment_method

        #sistema
        get '/info_system' => 'admins#info', as: :system_info
        get '/ejs_list' => 'users#ejs_list', as: :ej_list
        get '/ejs_chat' => 'users#ejs_chat', as: :ejs_chat

        #excel
        get 'excel/lot/users/:id' => 'excel#lot_users', as: :download_lot_users_excel
        #relatorio
        get 'relatorio' => 'excel#excel_handler', as: :excel_handler
        get 'excel/generate_xls' => 'excel#generate_xls', as: :generate_xls, format: :xls
        #ej
        get 'excel/ejlist' => 'excel#ejlist', format: :xls_ejlist
        #fed
        get 'excel/fedlist' => 'excel#fedlist', format: :xls_fedlist

        #acess account
        patch 'login_user/:user_id' => 'admins_methods#login', as: :login_user

        #hoteis
      end

      unauthenticated do

      end

      root 'admins#dashboard',  as: :authenticated_admin_root
    end
  end

  #routes for :users
  devise_for :users,
  controllers: {
    sessions: "users/sessions",
    passwords: "users/passwords",
    registrations: "users/registrations",
    confirmations: 'users/confirmations',
    omniauth_callbacks: "users/omniauth_callbacks"
  },
    path: "/",
    path_names: { sign_in: 'login_secret',
                  sign_out: 'logout_secret',
                  password: 'secret_secret',
                  unlock: 'unblock_secret',
                  registration: 'inscription_secret',
                  sign_up: 'new_secret' },
    :skip => 'registration'

  devise_scope :user do
    authenticated :user do
      root to: 'user_dashboard#index',  as: :authenticated_user_root
      get "cadastro/completar" => "after_registration#edit"
      get "email/completar" => "after_registration#edit_email"

      put "cadastro" => "after_registration#update"
      put "cadastro_email" => "after_registration#update_email"

      get '/senha/editar' => 'users/registrations#edit_password', :as => 'password_edit'
      put '/senha' => 'users/registrations#update_password'

      # routes for payment
      get "payment" => "checkout#new"

      put 'active_again' => 'user_dashboard#active_account', as: :active_again

      post 'payment_billet' => 'checkout#billet', as: :payment_billet
      put 'payment_billet_again' => 'checkout#try_again', as: :payment_billet_again

      post 'payment_pagseguro' => 'checkout#pagseguro', as: :payment_pagseguro

      post 'payment_deposit' => 'checkout#deposit', as: :payment_deposit

      #Sobre o evento
      get "about" => "user_dashboard#about"

      #Escolha dos quartos
      get 'hotels' => 'hotels#index', as: :hotels
      get 'hotels/:hotel_id/rooms' => 'rooms#index', as: :rooms
      patch 'hotels/:hotel_id/rooms/:id/insert_current_user' => 'rooms#insert_current_user_into_room', as: :insert_current_user_into_room
      patch 'hotels/:hotel_id/rooms/exit' => 'rooms#exit_room', as: :exit_room
      post 'room/change_name' => 'rooms#change_name', as: :change_name_room

      #Programação
      get 'events' => 'events#index', as: :events
      post 'events/enter' => 'events#enter_event', as: :enter_event
      post 'events/exit' => 'events#exit_event', as: :exit_event

      #get 'terms'  => 'terms#index'
      #put 'terms/update'  => 'terms#update'

      #certificado
      get 'certificate.pdf' => 'certificates#show'

    end
    unauthenticated :users do
      #root to: "users/sessions#new", as: :unauthenticated_user_root
      root to: "site#index", as: :site

      get 'reminder'  => "users/registrations#show_reminder"
    end

    get 'site' => 'site#index'


    get '/inscription/cancel' => 'users/registrations#cancel', :as => 'cancel_user_registration'

    get '/inscription/new_secret' => 'users/registrations#new', :as => 'new_user_registration'
    post '/inscription' => 'users/registrations#create', :as => 'user_registration'

    get '/inscription/edit' => 'users/registrations#edit', :as => 'edit_user_registration'
    put '/inscription' => 'users/registrations#update'



    #delete '/inscription' => 'users/registrations#destroy'
    post 'confirm_payment' => 'notifications#confirm_payment', as: :confirm_payment
    post 'confirm_payment_asaas' => 'notifications#confirm_payment_asaas', as: :confirm_payment_asaas
  end


end
