module Responses
  class CommandsBalance < DynamicResponse
    description "Describes how to use the balance command."

    default_body "balance: tells you your current balance owing, including any payments you have made that have not been received."
  end
end
