describe Commands::OdometerReport do
  let(:original_reading) { :original_reading }
  let(:car) { double(odometer_reading: original_reading, rate: 0.25) }
  let(:sharer) { double(balance: 10) }
  let(:reading) { 100 }

  context 'with a valid reading' do
    let(:report) { Commands::OdometerReport.new(car: car, sharer: sharer, reading: reading) }

    before do
      expect(car).to receive(:accept_report!).with(nil, reading)
    end

    context 'when the report is at the beginning of a borrowing' do
      before do
        expect(car).to receive(:borrowed?).and_return(true)
      end

      it 'sets the odometer reading, creates a borrowing, and generates a response' do
        expect(Borrowing).to receive(:create).with(car: car, sharer: sharer, initial: reading)

        report.execute

        expect(report).to have_response_from_car("Set odometer reading to #{reading}")
      end
    end

    context 'when the report is at the end of a borrowing' do
      before do
        expect(car).to receive(:borrowed?).and_return false
      end

      it 'sets the odometer reading, completes the borrowing, and generates a response' do
        borrowings = double
        borrowing = double(initial: 0)
        expect(Borrowing).to receive(:of).with(car).and_return borrowings
        expect(borrowings).to receive(:incomplete).and_return [borrowing]

        expect(borrowing).to receive(:final=).with(reading)
        expect(borrowing).to receive(:save)

        report.execute

        balance = sharer.balance + (reading.to_i - borrowing.initial)*car.rate

        expect(report).to have_response_from_car("Set odometer reading to #{reading}. Your balance is $#{balance}0.")
      end
    end
  end

  it 'rejects a lower odometer reading' do
    report = Commands::OdometerReport.new(car: car, sharer: sharer, reading: reading)

    expect(car).to receive(:accept_report!).with(nil, reading).and_raise InvalidOdometerReadingException

    report.execute

    expect(report).to have_response_from_car("Unable to set odometer reading to #{reading}, which is lower than the current reading of #{original_reading}")
  end
end
