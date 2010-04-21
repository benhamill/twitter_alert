module TwitterAlert
  module Alert
    attr_accessor :text, :date

    def initialize text, date
      self.text = text.to_s
      self.date = DateTime.parse(date.to_s)
    end

    def sent?
      @sent
    end

    def mark_sent
      @sent = true
    end
  end
end
