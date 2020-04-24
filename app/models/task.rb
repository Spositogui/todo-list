class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true

  enum priority: {default: 0, primary: 1, warning: 2, danger: 3}
end
