require 'httparty'

class NotificationService
  include HTTParty
  base_uri ENV['NOTIFICATION_SERVICE_URL'] || 'http://localhost:3001'

  def self.notify_user(user_id, data)
    # Rails.logger.info "[NotificationService] Sending to user #{user_id}: #{message}"
    begin
      response = post('/notify', 
                body: { userId: user_id, data: data}.to_json,
                headers: { 
                'Accept' => 'application/json',  
                'Content-Type' => 'application/json'
              }
      )
      Rails.logger.debug "[NotificationService] Response: #{response.code} - #{response.body}"
      response
    rescue => e
      Reails.logger.error " [NotificationService] Error: #{e.message}"
      # redirect_to root_url
    end
  end
end