class StoolRecordsController < ApplicationController
  before_action :authenticate_user!

  def new
    @stool_record = current_user.stool_records.build(recorded_on: params[:recorded_on])
  end

  def create
    @stool_record = current_user.stool_records.build(stool_record_params)

    if @stool_record.save
      redirect_to calendar_path(start_date: @stool_record.recorded_on), notice: "記録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def stool_record_params
    params.expect(stool_record: [ :recorded_on, :condition ])
  end
end
