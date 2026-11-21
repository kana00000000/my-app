class StoolRecordsController < ApplicationController
  before_action :authenticate_user!

  def new
    @stool_record = current_user.stool_records.build(recorded_on: params[:recorded_on])
    @existing_record = current_user.stool_record_on(@stool_record.recorded_on)
  end

  def create
    @stool_record = current_user.stool_records.build(stool_record_params)

    if @stool_record.save
      redirect_to_calendar @stool_record, notice: "記録しました"
    else
      @existing_record = current_user.stool_record_on(@stool_record.recorded_on)
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # 自分の記録だけを探す（他のユーザーの記録は見つからず、消せない）
    stool_record = current_user.stool_records.find(params[:id])
    stool_record.destroy!
    redirect_to_calendar stool_record, notice: "記録を消去しました", status: :see_other
  end

  private

  def stool_record_params
    params.expect(stool_record: [ :recorded_on, :condition ])
  end

  # 記録のある月のカレンダーに戻る
  def redirect_to_calendar(stool_record, **options)
    redirect_to calendar_path(start_date: stool_record.recorded_on), **options
  end
end
