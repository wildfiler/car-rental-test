class Rent < ApplicationRecord
  belongs_to :car

  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :correct_date_range

  private

  def correct_date_range
    if start_at.blank? || end_at.blank? || start_at > end_at
      errors.add(:end_at, 'end_at should be greater or equal to start_at')
    end
  end
end
