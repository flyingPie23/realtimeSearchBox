require "test_helper"

class RequestControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ip = "123.123.123.123"
    @headers = { "REMOTE_ADDR" => @ip }
  end

 test "should create a request" do
  assert_difference "Request.count", 1 do
    post requests_url, params: { query: "test search", ip_adress: @ip }, headers: @headers
  end

  request = Request.last
  assert_equal "test search", request.query
  assert_equal @ip, request.ip_adress
end


test "should create RequestAnalytic only for unique request" do
  assert_difference "RequestAnalytic.count", 1 do
    post requests_url, params: { query: "test search" }, headers: @headers
  end

  assert_no_difference "RequestAnalytic.count" do
    post requests_url, params: { query: "test search" }, headers: @headers
  end
end


  test "simulate_requests should create multiple requests and redirect" do
    before = Request.count

    post simulate_requests_url, headers: @headers

    after = Request.count
    assert_operator after - before, :>=, 1
    assert_redirected_to user_dashboard_path
  end


  test "clear_requests should delete only requests from current IP" do
    3.times do
      Request.create!(ip_adress: @ip, query: "delete me", timestamp: Time.now)
    end


    Request.create!(ip_adress: "111.111.111.111", query: "keep me", timestamp: Time.now)

    assert_difference "Request.count", -3 do
      delete clear_requests_url, headers: @headers
    end

    assert Request.where(ip_adress: "111.111.111.111").exists?
    assert_redirected_to user_dashboard_path
  end
end
