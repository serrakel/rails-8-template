class SessionsController < ApplicationController
  def new
    render({ :template => "sessions/new" })
  end

  def create
    email = params.fetch("email_address")
    password = params.fetch("password")

    matching_users = User.where({ :email_address => email })
    the_user = matching_users.at(0)

    if the_user != nil && the_user.authenticate(password)
      session.store(:user_id, the_user.id)
      redirect_to("/")
    else
      redirect_to("/session/new")
    end
  end

  def destroy
    session.store(:user_id, nil)
    redirect_to("/session/new")
  end
end
