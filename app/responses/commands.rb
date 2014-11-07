module Responses
  class Commands < DynamicResponse
    def self.default_body
      <<-TXT.strip_heredoc
        Available commands:

        balance
        book, confirm, cancel
        borrow, return

        gas

        pay

        status


        For help on a specific command, say:
        \"commands commandname\"
      TXT
    end
  end
end