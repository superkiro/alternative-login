class UsersController < ApplicationController
  def new
      @categories = Category.all
      @user = User.new
  end
  
  def create
    @user = User.new(params[:user].permit({pattern: []}, :username))
    s = @user.pattern[0]
    array = s.split(",")
    array1 = array.map{|s| s.to_i} 
    @user.pattern = array1
    @user.save
    session["user_id"] = @user.id
    redirect_to :controller => 'users', :action => 'home'
  end
  
  def login
    @user = User.find_by_username(params[:username])
    @pattern = @user.pattern
    
    @images = []
    @pos = []
    @pat = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @image_index = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    idx = 0
    @pattern.each do |p|
      if p != 0
        c = Category.find(p)
        @images << c.images.sample(1)[0]
        
        flag = true
        while flag == true do
          num = rand(16)
          if !@pos.include?(num)
            @pos << num
            @pat[num] = p
            @image_index[num] = idx
            idx = idx + 1
            puts p
            puts num
            flag = false
          end     
        end
      end
    end
    #@position = @pos.to_s
    puts @pat.to_s
  end
  
  def start
    if session[:user_id]
      redirect_to :controller => 'users', :action => 'home'
    end
  end
  
  def check
    u = User.find_by_username(params[:username])
    s = params[:pattern][0]
    array = s.split(",")
    array1 = array.map{|s| s.to_i} 
    puts "xxxxxxxxxxxxxxxxxxxxxxxxxx" + array1.to_s
    if array1 == u.pattern
      @msg = "Success"
      session[:user_id] = u.id
      
      if session["redirect_to"]
        redirect_to("#{session["redirect_to"]}?#{session["redirect_params"].to_query}")
      else
        puts "No redirect_url in session " + "*"*30
      end
    else
      @msg = "fail"
    end
  end
  
  def logout
    session[:user_id] = nil
    session.keys.each do |k,v|
      session[k] = nil
    end
    redirect_to controller: "users", action: "home"
  end
  
  def home
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end
end
