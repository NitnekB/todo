class Workspace < ApplicationRecord
  validates :label, presence: true, length: { minimum: 3 }
  validates :description, length: { minimum: 15, maximum: 500, too_long: "%{count} characters is the maximum allowed" },
    if: Proc.new { |a| a.description.present? }
  validates :public, inclusion: { in: [true, false] }
end
