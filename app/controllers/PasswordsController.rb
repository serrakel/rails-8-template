class PasswordsController < ApplicationController
  before_action(:set_user_by_token, { :only => [:edit, :update] })

  def new
    render({ :template => "passwords/new" })
  end

  def create
    email = params.fetch("email_address")

    matching_users = User.where({ :email_address => email })
    user = matching_users.at(0)

    if user != nil
      PasswordsMailer.reset(user).deliver_later
    end

    redirect_to("/session/new")
  end

  def edit
    render({ :template => "passwords/edit" })
  end

  def update
    @user.password = params.fetch("password")
    @user.password_confirmation = params.fetch("password_confirmation")

    if @user.save
      redirect_to("/session/new")
    else
      redirect_to("/passwords/" + params.fetch("token") + "/edit")
    end
  end

  private

  def set_user_by_token
    token = params.fetch("token")

    matching_users = User.where({ :password_reset_token => token })
    @user = matching_users.at(0)

    if @user == nil
      redirect_to("/passwords/new")
    end
  end
end
