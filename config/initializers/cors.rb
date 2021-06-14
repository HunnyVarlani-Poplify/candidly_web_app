Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://demo.localhost:3005', /\Ahttp:\/\/[\w](?:[\w-]{0,61}[\w])\.(demo)\.(localhost)\:(3005)/
    resource(
      '*',
      headers: :any,
      expose: %w(Authorization Tenant-Name),
      methods: [:get, :patch, :put, :delete, :post, :options, :show], 
      credentials: true
    )
  end
end