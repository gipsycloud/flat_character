require 'httparty'

class NotificationService
  include HTTParty
  base_uri ENV['NOTIFICATION_SERVICE_URL'] || 'http://localhost:3001'

  def self.notify_user(user_id, message)
    Rails.logger.info "[NotificationService] Sending to user #{user_id}: #{message.truncate(50)}"
    begin
      response = post('/notify', 
                body: { userId: user_id, message: message}.to_json,
                headers: { 'Content-Type' => 'application/json'
              }
      )
      Rails.logger.debug "[NotificationService] Response: #{response.code} - #{response.body}"
      response
    rescue => e
      Reails.logger.error " [NotificationService] Error: #{e.message}"
      nil
    end
  end
end