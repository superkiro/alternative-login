class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(params[:category].permit(:name))
    if @category.save
      redirect_to :controller => 'users', :action => 'new'
    else
      render 'new'
    end
  end
end
