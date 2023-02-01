class RecordsController < ApplicationController
 
    def index
        
       @record = Record.all
       
       @q=Record.ransack(params[:q])

       @records = @q.result(distinct: true)
       authorize @record
    end

    def new
       @record = Record.new
    end

    def create
    
    @record = Record.new(params.require(:record).permit(:name,:address,:age))
    authorize @record
       if @record.save 
            
           flash[:success] = "You have successfully entered your details"
           redirect_to root_path
       else
           render 'new'
       end
   end

   def show
       @record = Record.find(params[:id])
       
       
   end

   def edit
        @record = Record.find(params[:id])
   end
    
   def update
        @record = Record.find(params[:id])
        authorize @record
       if @record.update(params.require(:record).permit(:name,:address,:age))
        
           flash[:success] = "You have successfully updated your information"
           redirect_to records_path(@record)
       else
           render 'new'
       end
   end

   def destroy
        @record = Record.find(params[:id])
       @record.destroy
       redirect_to records_path
   end

   

end