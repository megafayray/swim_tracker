class SwimsController < ApplicationController
  def index
    @swims = Swim.all
    @total_spent = @swims.sum(:cost)
    @remaining = 295 - @total_spent

    @lane_count = @swims.where(swim_type: "lane").count
    @open_count = @swims.where(swim_type: "open").count

    @remaining_lane = (@remaining / 4.25).ceil
    @remaining_open = (@remaining / 15.00).ceil

    @season_start = Date.new(2025, 6, 13)
    @season_end = Date.new(2025, 8, 31)

    @today = Date.today

    @days_remaining = [(@season_end - @today).to_i, 0].max 
    #max chooses the highest value to display between the two values in the array
    #If the first number is a negative value, meaning that today's date is AFTER the season end date
    #the highest (max) number is 0 and is what will be displayed
    #This is cleaner than a conditional

  end

  def create
    swim_type = params[:swim_type]
    cost = swim_type == "lane" ? 4.25 : 15.00
    date = params[:date].present? ? Date.parse(params[:date]) : Date.today
  
    Swim.create(swim_type: swim_type, cost: cost, date: date)
    flash[:notice] = "Swim logged successfully."
    # redirect_to root_path
    redirect_to swims_path 
  end  

  def destroy
    @swim = Swim.find(params[:id])
    @swim.destroy
    flash[:notice] = "Swim deleted successfully."
    # redirect_to root_path
    redirect_to swims_path 
  end
end
