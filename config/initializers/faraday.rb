def faraday
  faraday = Faraday.new(url: DAXTRA_END_POINT) do |c|
  c.adapter Faraday::Request::UrlEncoded # encode request params as "www-form-urlencoded"
  c.adapter Faraday::Response::Logger # log request & response to STDOUT
  c.adapter Faraday::Adapter::NetHttp # perform requests with Net::HTTP
  end
end
  