class Report < ApplicationRecord
  # has_many :mentions
  has_many :mentioning_reports, class_name: "Mention", foreign_key: "report_id",  dependent: :destroy # (mentioning_report)
  has_many :mentioned_reports, class_name: "Mention", foreign_key: "mentioned_report_id",  dependent: :destroy # (mentioning_report)
  has_many :mentionings, through: :mentioning_reports, source: :mentioned_report
  has_many :mentionners, through: :mentioned_reports, source: :report

  def save_with_mentions
    Report.transaction do
      save!
      self.mentioning_ids = get_uris(content)
    end
      return true
    rescue ActiveRecord::RecordInvalid => invalid
      errors.add(:report, "の保存に失敗しました")
      return false
  end

  def update_with_mentions(params)
    Report.transaction do
      update!(params)
      self.mentioning_ids = get_uris(content)
    end
      return true
    rescue ActiveRecord::RecordInvalid => invalid
      errors.add(:report, "の更新に失敗しました")
      return false
  end

  private

  def get_uris(content)
    newa = URI.extract(content).map do |a|
      u = URI.parse(a)
      pa = u.path.split('/')[2].to_i if u.path.match?(/^\/reports\/(\d+)(\/|$)/)
      pa if Report.exists?(pa)
    end
    newa.compact.uniq
  end
end
