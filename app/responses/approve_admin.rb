module Responses
  class ApproveAdmin < DynamicResponse
    expose :approvee, presenter: "Sharer"

    def initialize(options)
      super

      @from = options[:car]
      @to = options[:admin]
    end

    def self.default_body
      "I have welcomed {{approvee.name}} to share me."
    end
  end
end
