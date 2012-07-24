Gitscm::Application.routes.draw do
  constraints(:host => 'whygitisbetterthanx.com') do
    root :to => 'site#redirect_wgibtx'
  end

  constraints(:host => 'progit.org') do
    root :to => 'site#redirect_book'
    match '*path' => 'site#redirect_book'
  end

  constraints(:subdomain => 'book') do
    root :to => 'site#redirect_book'
    match '*path' => 'site#redirect_combook'
  end

  get "site/index"

  match "/doc" => "doc#index"
  match "/docs" => "doc#ref"
  match "/docs/:file.html" => "doc#man", :as => :doc_file, :file => /[\w\-\.]+/
  match "/docs/:file" => "doc#man", :as => :doc_file, :file => /[\w\-\.]+/
  match "/docs/:file/:version" => "doc#man", :version => /[^\/]+/
  match "/test" => "doc#test"
  match "/doc/ext" => "doc#ext"

  %w{man ref git}.each do |path|
    match "/#{path}/:file" => redirect("/docs/%{file}")
    match "/#{path}/:file/:version" => redirect("/docs/%{file}/%{version}"),
                                       :version => /[^\/]+/
  end

  resource :book do
    match "/index"                          => redirect("/book")
    match "/commands"                       => "books#commands"
    match "/:lang"                          => "books#show"
    match "/:lang/:slug"                    => "books#section"
    match "/ch:chapter-:section.html"       => "books#chapter"
    match "/:lang/ch:chapter-:section.html" => "books#chapter"
  end

  match "/publish" => "doc#book_update"
  match "/related" => "doc#related_update"
  match "/:year/:month/:day/:slug" => "doc#blog", :year => /\d{4}/,
                                                  :month => /\d{2}/,
                                                  :day => /\d{2}/

  match "/about" => "about#index"
  match "/about/:section" => "about#index"

  match "/videos" => "doc#videos"
  match "/video/:id" => "doc#watch"

  match "/community" => "community#index"

  match "/admin" => "site#admin"

  match "/download" => "downloads#index"  # from old site
  match "/downloads" => "downloads#index"
  match "/downloads/guis" => "downloads#guis"
  match "/downloads/installers" => "downloads#installers"
  match "/downloads/logos" => "downloads#logos"
  match "/downloads/latest" => "downloads#latest"
  match "/download/:platform" => "downloads#download"
  match "/download/gui/:platform" => "downloads#gui"

  match "/search" => "site#search"
  match "/search/results" => "site#search_results"

  # mapping for jasons mocks
  match "/documentation" => "doc#index"
  match "/documentation/reference" => "doc#ref"
  match "/documentation/reference/:file.html" => "doc#man"
  match "/documentation/book" => "doc#book"
  match "/documentation/videos" => "doc#videos"
  match "/documentation/external-links" => "doc#ext"

  match "/course/svn" => "site#svn"
  match "/sfc" => "site#sfc"

  root :to => 'site#index'
end
