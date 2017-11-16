Rails.application.routes.draw do
  
  devise_scope :user do
    root to: "skynets#new"
    get 'users/sign_out' => "devise/sessions#destroy"
  end
  
  resources :skynets
  resources :vendors
  resources :vendor_categories
  resources :vendoritems
  resources :subscriptions
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }
  
  resources :users, only: [:edit, :update, :create, :new, :destroy]

  authenticated :user do
    root to: "skynets#new"
  end

  get '/plans' => 'subscriptions#plans'
  post '/stripe_checkout' => 'subscriptions#stripe_checkout'
  post '/subscription_checkout' => 'subscriptions#subscription_checkout'
  
  resources :companies

  get '/' => 'home#index'
  # defaults to dashboard
  root :to => redirect('/')

  # view routes
  get '/userlist' => 'home#userlist'
  get '/widgets' => 'widgets#index'
  get '/documentation' => 'documentation#index' 
  get 'dashboard/dashboard_buyer'
  get 'dashboard/dashboard_manager'
  get 'dashboard/dashboard_admin'
  get 'dashboard/dashboard_h'

  get 'skynets/download'
  get '/skynets/history' => 'skynets#history'

  post 'importskynet' => 'skynets#importskynet'
  post 'insertskynet' => 'skynets#insertskynet'

  namespace :api do
    get 'skynethisotry' => 'skynet#skynethisotry'
    
    get 'getitemlist' => 'vendoritem#getitemlist'
    post 'updatevendoritem' =>'vendoritem#updatevendoritem'
  end

  
  # get 'elements/button'
  # get 'elements/notification'
  # get 'elements/spinner'
  # get 'elements/animation'
  # get 'elements/dropdown'
  # get 'elements/nestable'
  # get 'elements/sortable'
  # get 'elements/panel'
  # get 'elements/portlet'
  # get 'elements/grid'
  # get 'elements/gridmasonry'
  # get 'elements/typography'
  # get 'elements/fonticons'
  # get 'elements/weathericons'
  # get 'elements/colors'
  # get 'elements/buttons'
  # get 'elements/notifications'
  # get 'elements/carousel'
  # get 'elements/tour'
  # get 'elements/sweetalert'
  # get 'forms/standard'
  # get 'forms/extended'
  get 'forms/validation'
  # get 'forms/wizard'
  # get 'forms/upload'
  # get 'forms/xeditable'
  # get 'forms/imgcrop'
  # get 'multilevel/level1'
  # get 'multilevel/level3'
  # get 'charts/flot'
  # get 'charts/radial'
  # get 'charts/chartjs'
  # get 'charts/chartist'
  # get 'charts/morris'
  # get 'charts/rickshaw'
  # get 'tables/standard'
  # get 'tables/extended'
  get 'tables/datatable'
  get 'tables/jqgrid'
  # get 'maps/google'
  # get 'maps/vector'
  # get 'extras/mailbox'
  # get 'extras/timeline'
  # get 'extras/calendar'
  # get 'extras/invoice'
  # get 'extras/search'
  # get 'extras/todo'
  # get 'extras/profile'
  # get 'extras/contacts'
  # get 'extras/contact_details'
  # get 'extras/projects'
  # get 'extras/project_details'
  # get 'extras/team_viewer'
  # get 'extras/social_board'
  # get 'extras/vote_links'
  # get 'extras/bug_tracker'
  # get 'extras/faq'
  # get 'extras/help_center'
  # get 'extras/followers'
  # get 'extras/settings'
  # get 'extras/plans'
  # get 'extras/file_manager'
  # get 'blog/blog'
  # get 'blog/blog_post'
  # get 'blog/blog_articles'
  # get 'blog/blog_article_view'
  # get 'ecommerce/ecommerce_orders'
  # get 'ecommerce/ecommerce_order_view'
  # get 'ecommerce/ecommerce_products'
  # get 'ecommerce/ecommerce_product_view'
  # get 'ecommerce/ecommerce_checkout'
  # get 'forum/forum_categories'
  # get 'forum/forum_topics'
  # get 'forum/forum_discussion'
  # get 'pages/login'
  # get 'pages/register'
  # get 'pages/recover'
  # get 'pages/lock'
  # get 'pages/template'
  # get 'pages/notfound'
  # get 'pages/maintenance'
  # get 'pages/error500'

  # # api routes
  # get '/api/documentation' => 'api#documentation'
  get '/api/datatable' => 'api#datatable'
  # get '/api/skynethisotry' => 'api#skynethisotry'
  get '/api/jqgrid' => 'api#jqgrid'
  get '/api/jqgridtree' => 'api#jqgridtree'
  
  # get '/api/i18n/:locale' => 'api#i18n'
  # post '/api/xeditable' => 'api#xeditable'
  # get '/api/xeditable-groups' => 'api#xeditablegroups'

  # # the rest goes to root
  # get '*path' => redirect('/')

end
