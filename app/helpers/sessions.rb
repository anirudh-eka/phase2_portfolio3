helpers do

  def current_user
    # TODO: return the current user if there is a user signed in.
 	user = User.find_by_id(session[:user_id])
 	return user
  end

end
