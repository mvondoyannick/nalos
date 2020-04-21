module OneSignal
  class OnSignal
    include HTTParty

    HEADERS = {
      :Authorization => 'Basic NjEyMWNjYjgtYjMzMy00ZWUzLTgyNjUtOWU3NzJkNTdkZjUz',
        'Content-Type' => 'application/json'
    }

    # Create new file to storage log of pushes.
    @push_logger = ::Logger.new(Rails.root.join('log', 'push.log'))

    # Every request needs to inform the APP ID.
    @body = {
      'app_id' => '61094896-57dd-4135-a3b5-ca0ca68f5c3d'
    }

    def self.send_push(body)
      HTTParty.post 'https://onesignal.com/api/v1/notifications', headers: HEADERS, body: body, logger: @push_logger, log_level: :debug, log_format: :curl
    end

    # Send push to all users.
    def self.daily_news
      push_body = @body.merge(
        {
          :included_segments => ['All'],
            :url => 'https://onesignal.com',
            :data => {"type": 'daily_news'},
            :contents => {:en => 'News!', :pt => 'Novidades!'}
        }).to_json

      send_push(push_body)
    end

    # Send push to specific user.
    def self.new_comment(comment)
      push_body = @body.merge(
        {
          :url => 'https://onesignal.com',
            :include_player_ids => [comment.user.onesignal_id],
            :data => {"type": 'new_comment', "id": comment.id},
            :contents => {:en => 'You have received a new comment.', :pt => 'Você recebeu um novo comentário.'}
        }).to_json

      send_push(push_body)
    end
  end
end

#Now, to call any method, just use the lines below at any point in the Ruby on Rails project: Push::Notify.new_comment(comment)

#Push::Notify.daily_news()