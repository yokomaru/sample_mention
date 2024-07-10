class Mention < ApplicationRecord
  belongs_to :report
  belongs_to :mentioned_report, class_name: "Report"
  #validates :report_id, uniqueness: { scope: :mentioned_report_id }
  # belongs_to :mentioning_report, class_name: "Report"
  # belongs_to :mentioned_report, class_name: "Report"
#   belongs_to :from_report, class_name: Report, foreign_key: :report_id
#   belongs_to :mentioned_report, class_name: Report,   foreign_key: :mentioned_report_id
end
