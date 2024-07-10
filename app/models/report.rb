class Report < ApplicationRecord
  # has_many :mentions
  has_many :mentioning_reports, class_name: "Mention", foreign_key: "report_id",  dependent: :destroy # (mentioning_report)
  has_many :mentioned_reports, class_name: "Mention", foreign_key: "mentioned_report_id",  dependent: :destroy # (mentioning_report)
  has_many :mentionings, through: :mentioning_reports, source: :mentioned_report
  has_many :mentionners, through: :mentioned_reports, source: :report


  # after_save :save_mention
  # def save_mention
  #   self.mentioning_ids = get_uris(content)
  #   #followed.microposts.create!(content: "#{follower.name}があなたをフォローしました。")
  # end


  def save_with_mentions
    Report.transaction do
      save!
      self.mentioning_ids = fetch_report_ids(content)
    end
      true
    rescue ActiveRecord::RecordInvalid => invalid
      logger.error invalid.message
      logger.error invalid.backtrace.join("\n")
      errors.add(:report, "の保存に失敗しました")
      false
  end

  def update_with_mentions(params)
    Report.transaction do
      update!(params)
      self.mentioning_ids = fetch_report_ids(content)
    end
    rescue ActiveRecord::RecordInvalid => invalid
      logger.error invalid.message
      logger.error invalid.backtrace.join("\n")
      errors.add(:report, "の更新に失敗しました")
      false
  end

  private

  def fetch_report_ids(content)
    registered_report_ids = Report.all.ids
    report_ids = URI.extract(content).map do |url|
      matched_report = url.match(/http\:\/\/localhost\:3000\/reports\/(\d+)(\/|$)/)
      report_id = matched_report[1].to_i if matched_report.present?
      report_id if registered_report_ids.include?(report_id)
    end
    report_ids.compact.uniq
  end
end
