class CalendarsController < ApplicationController
  before_action :authenticate_user!

  def show
    start_date = params.fetch(:start_date, Date.current).to_date
    @stool_records = current_user.stool_records.in_calendar_month(start_date)
  end
end
