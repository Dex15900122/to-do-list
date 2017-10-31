class ListsController < ApplicationController
  def index
    @lists = List.all
  end
  def new
    @list = List.new
  end
  def create
    @list = List.new(list_params)
    if @list.save

    redirect_to lists_url
    else 
      render :action => :new
    end
  end  
  def show
    @list = List.find(params[:id])
  end
  
  def edit
    @list = List.find(params[:id])
  end
  
  def update
    @list = List.find(params[:id]) 
    if @list.update_attributes(list_params)
       redirect_to list_path(@list) 
    else 
      render :action => :edit
    end  
  end
  def destroy
    @list = List.find(params[:id])
      if  @list.duedate >  Time . now 

        @list.destroy
        redirect_to lists_url
      else  
        
           render :action => :edit
            
          
        
      end
      
  end  
     def complete
    if @list.completed == false
      @list.update_attribute(:completed, true)
    else
      @list.update_attribute(:completed, false)
    end
    redirect_to list_path(@list)
  end

  private

  def list_params
    params.require(:list).permit(:name, :duedate, :note)
  end  



end
