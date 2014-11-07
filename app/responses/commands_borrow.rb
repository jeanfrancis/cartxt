module Responses
  class CommandsBorrow < DynamicResponse
    def self.default_body
      "borrow: start the process of borrowing the car right now."
    end
  end
end