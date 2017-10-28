class ArticlesController < ApplicationController
  
  before_action :set_article , only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  
  def update 
    
    if @article.update(article_params)
      flash[:success] = "mis à jour"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end  
  
  def index
    @articles = Article.all
  end

  
  def new
    
    @article = Article.new
    
  end
  
  def create 
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was succesfully created"
      redirect_to article_path(@article)  
    else
      render 'new'

    end
   
  end
  
  def show 
    
  end
  
  def edit 
    
  end
  
  def destroy
  @article.destroy
  flash[:danger] = "L'article a bien été détruit"
  redirect_to articles_path
  end
  
  
    
  private
  
    def require_same_user
    
    if current_user != @article.user and !current_user.admin?
    
    flash[:danger]= "Vous n'êtes pas l'auteur de cet article"
    redirect_to articles_path
    
    end
    
    end
  
    
    def set_article
    
    @article = Article.find(params[:id])
    
    end
    
  def article_params

  params.require(:article).permit(:title, :description, category_ids: [])
  
  end
end
