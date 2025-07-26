class PagesController < ApplicationController
  def home
  end

  def user_dashboard
    @requests = Request.where(ip_adress: request.remote_ip)
    @requests_5days = Request.where(timestamp: 5.days.ago..Time.now).where(ip_adress: request.remote_ip)
    @top_requests = RequestAnalytic.where(request_id: @requests.pluck(:id)).order(count: :desc).limit(5)
  end

  def global_dashboard
    @requests = Request.all
    @requests_ips = @requests.to_a.group_by(&:ip_adress)
    @request_today = Request.where(timestamp: Date.today)
    @daily_average = Request.count / 30
  end
end
