class CalendarsController < ApplicationController
  before_action :authenticate_user!

  def show
    start_date = params.fetch(:start_date, Date.current).to_date
    @stool_records = current_user.stool_records.where(
      recorded_on: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week
    )
  end
end
