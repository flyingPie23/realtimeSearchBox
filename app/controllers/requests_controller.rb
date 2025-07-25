class RequestsController < ApplicationController
  protect_from_forgery with: :null_session
  def create
    Request.create!(
      ip_adress: request.remote_ip,
      query: params[:query],
    )
    head :ok
  end
end
