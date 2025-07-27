class RequestsController < ApplicationController
  protect_from_forgery with: :null_session
  def create
    @request = Request.create!(
      ip_adress: request.remote_ip,
      query: params[:query],
      timestamp: Time.now
    )


    tracked_request = Request.find_by(ip_adress: request.remote_ip, query: params[:query])

    save_request(tracked_request, @request)

    head :ok
  end

  def simulate_requests
    generate_fake_queries.each do |query|
        @request = Request.create!(
          ip_adress: request.remote_ip,
          query: generate_fake_queries.sample,
          timestamp: Faker::Time.between(from: 1.month.ago, to: Time.now)
        )

        tracked_request = Request.find_by(ip_adress: @request.ip_adress, query: @request.query)

        save_request(tracked_request, @request)
    end

    redirect_to user_dashboard_path
  end

  def clear_requests
    @requests = Request.where(ip_adress: request.remote_ip)
    @requests.destroy_all

    redirect_to user_dashboard_path
  end

  def search_suggestions
    query = params[:query].to_s.strip

    suggestions = Request
      .where("query ILIKE ?", "%#{query}%")
      .distinct
      .order(:query)
      .limit(5)
      .pluck(:query)

    render json: suggestions
  end


  private
  def generate_fake_queries
    prefix = [ "what is", "where to find", "reviews of" ]
    queries = []

    prefix.each do |p|
      10.times do
        queries << "#{p} #{Faker::Movie.title}"
        queries << "#{p} #{Faker::Book.title}"
        queries << "#{p} #{Faker::Music.band}"
      end
    end

    queries
  end

  def save_request(tracked_request, request)
    if tracked_request && tracked_request.id != request.id
      analytics = RequestAnalytic.find_or_initialize_by(request_id: tracked_request.id)
    else
      analytics = RequestAnalytic.find_or_initialize_by(request_id: request.id)
    end

    analytics.count ||= 0
    analytics.count += 1
    analytics.save!
  end
end
