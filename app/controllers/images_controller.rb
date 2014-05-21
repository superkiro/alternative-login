class ImagesController < ApplicationController
  def new
    @image = Image.new
  end
  
  def create
    @image = Image.new(params[:image].permit(:category_id, :url))
    if @image.save
      redirect_to :controller => 'users', :action => 'new'
    else
      render 'new'
    end
  end
end
