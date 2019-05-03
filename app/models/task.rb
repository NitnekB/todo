class Task < ApplicationRecord
  belongs_to :project

  STATES = %W(TODO DOING DONE).freeze

  validates :title, presence: true, length: { minimum: 3 }
  validates :state, presence: true, inclusion: { in: STATES }
end
