class ApplicationController < ActionController::Base
  helper_method(:current_user)

  def current_user
    user_id = session.fetch(:user_id, nil)

    if user_id == nil
      return nil
    end

    if defined?(@current_user) && @current_user != nil
      return @current_user
    end

    matching_users = User.where({ :id => user_id })
    @current_user = matching_users.at(0)

    return @current_user
  end

  def require_user_signed_in
    if current_user == nil
      redirect_to("/session/new")
    end
  end
end
