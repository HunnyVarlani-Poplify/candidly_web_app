Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource(
      '*',
      headers: :any,
      expose: %w(Authorization Tenant-Name),
      methods: [:get, :patch, :put, :delete, :post, :options, :show], 
      credentials: false
    )
  end
end