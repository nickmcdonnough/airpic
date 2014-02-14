class StampsController < ApplicationController
  def create
    Stamp.create(stamp_params)
  end

  private

  def stamp_params
    params.require(:stamp).permit(:user_id, :quantity, :date, :notes)
  end
end