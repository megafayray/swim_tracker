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
    @days_remaining = (@season_end - @today).to_i
  end

  def create
    swim_type = params[:swim_type]
    cost = swim_type == "lane" ? 4.25 : 15.00
    date = params[:date].present? ? Date.parse(params[:date]) : Date.today
  
    Swim.create(swim_type: swim_type, cost: cost, date: date)
    redirect_to root_path
  end  

  def destroy
    @swim = Swim.find(params[:id])
    @swim.destroy
    flash[:notice] = "Swim deleted successfully."
    redirect_to root_path
  end
end
