class Borrowing < ActiveRecord::Base
  belongs_to :car
  belongs_to :sharer
  belongs_to :booking

  scope :of, ->(car) { where(car_id: car.id) }
  scope :incomplete, -> { where(final: nil) }

  def span
    final - initial
  end
end
