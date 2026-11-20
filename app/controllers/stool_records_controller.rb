class StoolRecordsController < ApplicationController
  before_action :authenticate_user!

  def new
    @stool_record = current_user.stool_records.build(recorded_on: params[:recorded_on])
    @existing_record = find_existing_record(@stool_record.recorded_on)
  end

  def create
    @stool_record = current_user.stool_records.build(stool_record_params)

    if @stool_record.save
      redirect_to calendar_path(start_date: @stool_record.recorded_on), notice: "記録しました"
    else
      @existing_record = find_existing_record(@stool_record.recorded_on)
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # 自分の記録だけを探す（他のユーザーの記録は見つからず、消せない）
    stool_record = current_user.stool_records.find(params[:id])
    stool_record.destroy!
    redirect_to calendar_path(start_date: stool_record.recorded_on), notice: "記録を消去しました", status: :see_other
  end

  private

  def stool_record_params
    params.expect(stool_record: [ :recorded_on, :condition ])
  end

  def find_existing_record(recorded_on)
    return if recorded_on.blank?

    current_user.stool_records.find_by(recorded_on: recorded_on)
  end
end
