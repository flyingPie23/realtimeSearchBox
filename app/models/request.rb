class Request < ApplicationRecord
  has_many :request_analytics, dependent: :destroy
end
