class UsersController < ApplicationController
  
  before_action :set_up , only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :update]
  before_action :require_admin, only: [:destroy]
  
  def new
    @user = User.new  
  end
  
  def create

   @user = User.new(user_params)
   
   if @user.save
     
     flash[:success] = "Votre compte a bien été crée"
     redirect_to articles_path
     
     session[:user_id] = @user.id
     
    else
      render 'new'
      
    end 

  end
  
  def edit 
    
  end
  
  def update
  
    
    if @user.update(user_params)
    
      flash[:success] = "Your account was updated successfully"
      
      redirect_to user_path(@user)
      
    else
    
     render 'edit'
    
    end
    
  end
  
  def show
    
    @user_pagination = @user.articles.paginate(page: params[:page], per_page:2)
  
  end
  
  def index
  
    @users = User.paginate(page: params[:page], per_page:5)
  
  end
  
  def destroy
    
    @user.destroy
    flash[:danger]= "Utilisateur supprimé"
    redirect_to users_path
  
  end
  
  


private

  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger]="vous n'avez pas accès à cette action"
      redirect_to root_path
    end
  end

  def require_same_user
    if  current_user != @user and !current_user.admin?
      flash[:danger] = "vous pouvez simplement modifier votre profil"
      redirect_to articles_path
    end
    
  end
  
  def set_up
     @user=User.find(params[:id])
  
  end
  
  def user_params
  
  params.require(:user).permit(:username, :email, :password)
  
  end
  

end