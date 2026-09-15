class Task < ApplicationRecord
  validates :title, presence: true
  enum :status, { pending: 0, in_progress: 1, completed: 2 }
  belongs_to :user
end