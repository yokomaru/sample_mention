module ReportsHelper
  # 現在の時刻と日報の作成日の差分を求め経過時間を表示
  def display_time_difference_between_now_and_created_at(created_at)
    time_difference = Time.zone.now  - created_at

    if time_difference < 60 # 秒
      "#{(time_difference).floor} seconds ago"
    elsif 60 < time_difference && time_difference < 3600 # 分
      "#{(time_difference / 60).floor} minutes ago"
    elsif 3600 < time_difference && time_difference < 86400 # 時
      "#{(time_difference / 3600).floor} hour ago"
    elsif 86400 < time_difference && time_difference < 2592000 # 日
      "#{(time_difference / 86400).floor} day ago"
    elsif 2592000 < time_difference && time_difference < 31536000 # 月
      "#{(time_difference / 2592000).floor} month ago"
    elsif time_difference > 31360000 # 月
      "#{(time_difference / 31360000).floor} year ago"
    end
  end
end
