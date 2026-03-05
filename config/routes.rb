Rails.application.routes.draw do
  devise_for :users
  # Root
  get("/", { :controller => "user_books", :action => "index" })

  # Devise routes for users
  devise_for(:users)

  # Session (login/logout)
  get("/session/new", { :controller => "sessions", :action => "new" })
  post("/session", { :controller => "sessions", :action => "create" })
  get("/session/destroy", { :controller => "sessions", :action => "destroy" })

  # Password reset (token-based)
  get("/passwords/new", { :controller => "passwords", :action => "new" })
  post("/passwords", { :controller => "passwords", :action => "create" })
  get("/passwords/:token/edit", { :controller => "passwords", :action => "edit" })
  post("/passwords/:token", { :controller => "passwords", :action => "update" })

  # Books (new, create, show only)
  get("/books/new", { :controller => "books", :action => "new" })
  post("/books", { :controller => "books", :action => "create" })
  get("/books/:id", { :controller => "books", :action => "show" })

  # UserBooks (full CRUD)
  get("/user_books", { :controller => "user_books", :action => "index" })
  get("/user_books/new", { :controller => "user_books", :action => "new" })
  post("/user_books", { :controller => "user_books", :action => "create" })
  get("/user_books/:id", { :controller => "user_books", :action => "show" })
  get("/user_books/:id/edit", { :controller => "user_books", :action => "edit" })
  post("/user_books/:id/update", { :controller => "user_books", :action => "update" })
  get("/user_books/:id/destroy", { :controller => "user_books", :action => "destroy" })

  # Recommendations
  get("/recommendations", { :controller => "recommendations", :action => "index" })
  post("/recommendations/generate", { :controller => "recommendations", :action => "generate" })
  post("/recommendations/:id/pin", { :controller => "recommendations", :action => "pin" })
  post("/recommendations/:id/reject", { :controller => "recommendations", :action => "reject" })
  get("/recommendations/:id/destroy", { :controller => "recommendations", :action => "destroy" })
end
