class Workspace < ApplicationRecord
  # Relations
  has_many :projects, dependent: :destroy

  # Validations
  validates :label, presence: true, length: { minimum: 3 }
  validates :description, length: { minimum: 15, maximum: 256, too_long: "%{count} characters is the maximum allowed" },
    if: Proc.new { |a| a.description.present? }
  validates :public, inclusion: { in: [true, false] }
end
