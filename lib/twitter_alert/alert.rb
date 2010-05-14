module TwitterAlert

  # Mix this in to a class you want to represent the messages you'll DM out.
  module Alert

    # The text to be DMed out.
    attr_reader :text

    # The date it should be DMed out.
    attr_reader :date

    # An array of hashes containing the id and error text of any DMs that didn't work.
    attr_reader :failed_announcements

    # Text will have to_s called on it. Date will have #to_s and then fed to DateTime.parse
    def initialize text, date
      @text = text.to_s
      @date = DateTime.parse(date.to_s)
      @failed_announcements = []
    end

    # Returns boolean based on whether this messages was successfully sent to all followers or not.
    def sent?
      @sent
    end

    # Marks this message as sent unless there are stored failed announcements.
    def mark_sent
      @sent = @failed_announcements.empty?
    end

    # Stores a failed announcement so that you can see who and why the failure occured.
    def add_failed_announcement follower_id, error_text
      @failed_announcements << { :follower_id => follower_id, :error_text => error_text }
    end
  end
end
