describe Commands::Parser do
  let(:txt) { Txt.new(from: :from, to: :to, body: body) }

  def parsed_command
    Commands::Parser.new(txt).parse
  end

  context 'when the command is a status request' do
    let(:body) { 'status' }

    it 'it returns a Status command' do
      status_double = double
      expect(Commands::Status).to receive(:new).with(car: Car.first, sharer: Sharer.new(number: :from)).and_return status_double

      expect(parsed_command).to be(status_double)
    end
  end

  context 'when the command is an odometer report' do
    let(:body) { '555' }

    it 'returns an OdometerReport command' do
      report_double = double
      expect(Commands::OdometerReport).to receive(:new).with(car: Car.first, sharer: Sharer.new(number: :from), reading: body).and_return report_double
      expect(parsed_command).to be(report_double)
    end
  end

  context 'when the command is a borrow request' do
    let(:body) { 'borrow' }

    it 'returns a Borrow command' do
      borrow_double = double
      expect(Commands::Borrow).to receive(:new).with(car: Car.first, sharer: Sharer.new(number: :from)).and_return borrow_double

      expect(parsed_command).to be(borrow_double)
    end
  end
end
