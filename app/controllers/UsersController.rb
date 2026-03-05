class UsersController < ApplicationController
  def new
    render({ :template => "users/new" })
  end

  def create
    @user = User.new

    @user.email = params.fetch("email")
    @user.password = params.fetch("password")
    @user.password_confirmation = params.fetch("password_confirmation")

    @user.save

    # Auto‑sign in after signup (optional but nice)
    session.store(:user_id, @user.id)

    redirect_to("/")
  end
end
