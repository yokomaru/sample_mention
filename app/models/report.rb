class Report < ApplicationRecord
  has_many :mentions
  has_many :mentioning_reports, class_name: "Mention", foreign_key: "mentioning_report_id",  dependent: :destroy # (mentioning_report)
  has_many :mentioned_reports, class_name: "Mention", foreign_key: "mentioned_report_id",  dependent: :destroy # (mentioning_report)



  # has_many :mentions
  # has_many :mentionings, through: :mentions, source: :mentioning_report
  # has_many :mentioneds, class_name: 'Mention', foreign_key: 'follow_id'
#   # has_many :followers, through: :reverse_of_relationships, source: :user
# end



  # has_many :mentioning_report, class_name: Mention, foreign_key: :mentioning_report_id, dependent: :destroy
  # has_many :mentioned_report,   class_name: Mention, foreign_key: :mentionined_report_id,   dependent: :destroy

  # has_many :mentioning, through: :mentioning_report, source: :to_user
  # has_many :mentioned,  through: :mentioned_report,   source: :from_user
end
