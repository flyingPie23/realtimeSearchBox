class RequestsController < ApplicationController
  protect_from_forgery with: :null_session
  def create
    @request = Request.create!(
      ip_adress: request.remote_ip,
      query: params[:query],
      timestamp: Time.now
    )


    tracked_request = Request.find_by(ip_adress: request.remote_ip, query: params[:query])

    if tracked_request && tracked_request.id != @request.id
      analytics = RequestAnalytic.find_or_initialize_by(request_id: tracked_request.id)
    else
      analytics = RequestAnalytic.find_or_initialize_by(request_id: @request.id)
    end

    analytics.count ||= 0
    analytics.count += 1
    analytics.save!

    head :ok
  end
end
