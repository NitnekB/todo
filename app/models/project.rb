class Project < ApplicationRecord
  belongs_to :workspace

  validates :title, presence: true, length: { minimum: 3 }
end
