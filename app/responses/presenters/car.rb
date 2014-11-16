module Responses
  module Presenters
    class Car < Liquid::Drop
      delegate :returned?, :borrowed?, :description, :location_information, :lockbox_information, :odometer_reading, :rate, to: :@car

      def initialize(car)
        @car = car
      end

      def next_booking
        next_booking = @car.next_booking

        if next_booking
          # FIXME how to make editable
          "Note that it is booked as of #{next_booking.begins_at.to_formatted_s}."
        else
          ''
        end
      end

      def current_booking
        Presenters::Booking.new(@car.current_booking)
      end
    end
  end
end
