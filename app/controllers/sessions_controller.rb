class SessionsController < ApplicationController 
  
  def new 
    
  end
  
  def create
    
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      flash[:success]="Vous êtes connécté"
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Mauvais mot de passe"
      render "new"
      
    end
    
  end
  
  def destroy
    
    session[:user_id]= nil
    flash[:sucess] = "Vous etes deconnécté"
    redirect_to root_path  
  
  end

end
