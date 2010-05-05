module TwitterAlert
  module Alert
    attr_reader :text, :date, :failed_announcements

    def initialize text, date
      self.text = text.to_s
      self.date = DateTime.parse(date.to_s)
    end

    def sent?
      @sent
    end

    def mark_sent
      @sent = @failed_announcements.empty?
    end

    def add_failed_announcement follower_id, error_text
      @failed_announcement << { :follower_id => follower_id, :error_text => error_text }
    end
  end
end
