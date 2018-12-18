Rails.application.routes.draw do

  resources :documents

  resources :events

  resources :event_types

  resources :off_days

  resources :orders do
    collection do
      get 'proceed'
      get 'info'
    end
  end

  resources :positions

  resources :special_groups

  resources :announcements

  resources :season_tests

  resources :attendance_sheets do
    resources :attendances
  end

  resources :attendances do
    collection do
      get 'sms_sender'
    end
  end

  resources :mod_actions_roles

  resources :audits

  resources :mod_actions

  resources :mod_objects

  resources :book_contest_participants do
    collection do
      get 'book_contest_register'
    end
  end

  resources :contestant_books

  resources :book_contests

  get 'book_contests/:id/contest_info' => 'book_contests#contest_info', as: :contest_info
  get 'book_contests/:id/participants' => 'book_contests#participants', as: :participants

  resources :roles do
    collection do
      get 'edit_privileges'
      #match :privileges, to: 'roles#privileges', via: :post
    end
  end


  resources :finals do
    collection do
      get 'submit'
      get 'submitted'
      get 'edit'
    end
  end


  resources :midterms do
    collection do
      get 'submit'
      get 'submitted'
      get 'edit'
      get 'edited'
    end
  end

  resources :books do
    collection do
      get 'search'
    end
  end

  resources :book_contests

  resources :contestant_books

  resources :finals

  resources :midterms

  resources :book_lends

  resources :authors_books

  resources :books

  resources :book_languages

  resources :authors

  resources :notes_users

  resources :notes

  resources :roles_users

  resources :roles

  #resources :roles do
    #match :edit_privileges, on: :member, as: :edit_privileges, via: :post
    #post :edit_privileges, on: :member
  #end
  #get 'roles/:id/edit_privileges' => 'roles#edit_privileges', as: :edit_privileges

  resources :users

  get 'users/:id/edit_profile' => 'users#edit_profile', as: :edit_profile
  #put 'users/:id/update_profile' => 'users#update_profile', as: :update_profile
  patch 'users/:id/update_profile' => 'users#update_profile', as: :update_profile

  resources :payment_types

  resources :special_schools

  resources :high_schools

  resources :cities

  resources :states

  resources :settings

  resources :subject_categories

  resources :user_sessions

  get 'login' => 'user_sessions#new', :as => :login
  delete 'logout' => 'user_sessions#destroy', :as => :logout
  get 'welcome_admin' => 'user_sessions#welcome_admin', :as => :welcome_admin
  get 'welcome_registrar' => 'user_sessions#welcome_registrar', :as => :welcome_registrar
  get 'welcome_teacher' => 'user_sessions#welcome_teacher', :as => :welcome_teacher
  get 'welcome_dep_manager' => 'user_sessions#welcome_dep_manager', :as => :welcome_dep_manager
  get 'welcome_testing_manager' => 'user_sessions#welcome_testing_manager', :as => :welcome_testing_manager
  get 'welcome_examinator' => 'user_sessions#welcome_examinator', :as => :welcome_examinator
  get 'welcome_librarian' => 'user_sessions#welcome_librarian', :as => :welcome_librarian
  get 'welcome_observer' => 'user_sessions#welcome_observer', :as => :welcome_observer


  resources :contracts do
    collection do
      get 'repeating'
      get 'reserve'
      get 'birthdays'
      get 'general_report'
      get 'agaly_report'
      get 'tgb_report'
      get 'passers_check_report'
      get 'photoless_report'
      get 'incorrect_phones_report'
      get 'discount_report'
      get 'search'
      get 'mycontractssearch'
      get 'mycontractsreport'
      get 'health_notes_report'
      get 'birthday_sms_sender'
      #patch 'return_payment'
    end
    patch :return_payment
  end


  resources :students do
    collection do
      get 'repeating'
      get 'search'
    end
  end

  resources :timetables do
    collection do
      get 'plan'
      get 'class_states'
      get 'teachers_states'
      get 'available_teachers'
    end
  end

  #get 'groups/:id/info_list' => 'groups#info_list'
  get 'groups/:id/info_list' => 'groups#info_list', as: :info_list
  get 'groups/:id/attendance_list' => 'groups#attendance_list', as: :attendance_list
  get 'groups/:id/attendance_report' => 'groups#attendance_report', as: :attendance_report

  resources :groups do
    collection do
      get 'availability'
      get 'availability_granica'
      get 'information'
      get 'agaly_report'
    end
  end

  get 'contracts/:id/invoice' => 'contracts#invoice', as: :invoice
  get 'contracts/:id/content_ru' => 'contracts#content_ru', as: :content_ru
  get 'contracts/:id/content_tm' => 'contracts#content_tm', as: :content_tm
  get 'contracts/:id/att_report' => 'contracts#att_report', as: :att_report

  resources :contracts

  resources :timetables

  resources :students

  get 'students/:id/info_list' => 'students#info_list'

  resources :groups

  resources :exams

  resources :group_genders

  resources :group_languages

  resources :discounts

  resources :subjects


  resources :seasons

  get 'seasons/:id/change_active_season' => 'seasons#change_active_season', as: :change_active_season
  get 'seasons/:id/teachers_list' => 'seasons#teachers_list'
  get 'seasons/:id/info_list' => 'seasons#info_list'
  get 'seasons/:id/subject_report' => 'seasons#subject_report'


  #get 'roles/:id/edit_privileges' => 'roles#edit_privileges', as: :edit_privileges

  resources :lesson_times

  resources :rooms

  resources :teachers do
    collection do
      get 'groups_list'
      #match :privileges, to: 'roles#privileges', via: :post
    end
  end
  #get 'teachers/:id/groups_list' => 'teachers#groups_list', as: :groups_list

  resources :nationalities

  root :to => 'user_sessions#new'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

end