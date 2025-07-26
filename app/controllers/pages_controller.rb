class PagesController < ApplicationController
  def home
  end

  def user_dashboard
    @requests = Request.where(ip_adress: request.remote_ip)
  end

  def gloabal_dashboard
  end
end
