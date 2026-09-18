class HealthController < ApplicationController
	layout 'layouts/application_web'
	def redis
    Redis.current.ping 
    
    render json: { status: "ok", redis: "connected" }, status: :ok
  rescue Redis::CannotConnectError, Errno::ECONNREFUSED => e
    render json: { status: "error", redis: "disconnected", message: e.message }, status: :service_unavailable
  end
end
