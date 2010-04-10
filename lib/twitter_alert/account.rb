module TwitterAlert
  class Account
    def initialize config
      # Load hash from yaml file in default location?

      @username = config[:user_name]
      @password = config[:password]

      begin
        @client = Grackle::Client.new(
          :auth => {
            :type => :basic,
            :username => @username,
            :password => @password
          }#,
  #       :ssl => true
        )
      rescue Grackle::TwitterError, e
        #put something here, I'm sure.
      end
    end

    def announce message
      followers.each do |follower|
        begin
          @client.direct_messages.new! :user_id => follower, :text => message.text
        rescue Grackle::TwitterError, e
          @failed_announcements ||= []
          @failed_announcements << follower
        end
      end

      message.mark_sent
    end

    def followers
      @client.followers.ids? :screen_name => @user_name
    end
  end
end
