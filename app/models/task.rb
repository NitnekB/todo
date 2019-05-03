class Task < ApplicationRecord
  belongs_to :project

  validates :title, presence: true, length: { minimum: 3 }
  validates :state, presence: true
end
