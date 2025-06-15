module ApplicationHelper
  def custom_posted_time(timestamp)
    # 投稿されてから60秒未満の場合
    if (Time.current - timestamp) < 60
      "たった今投稿"
    else
      # 60秒以上の場合
      time_ago_raw = time_ago_in_words(timestamp)
      formatted_time = time_ago_raw.strip
                                    .sub('about', '')
                                    .gsub('minutes', '分')
                                    .gsub('minute', '分')
                                    .gsub('hours', '時間')
                                    .gsub('hour', '時間')
                                    .gsub('days', '日')
                                    .gsub('day', '日')
      "#{formatted_time}前に投稿"
    end
  end
end
