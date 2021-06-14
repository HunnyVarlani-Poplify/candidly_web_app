# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_candidly_session', secure: true, same_site: :none, tld_length: 2, domain: {
    production:   '.candidly.com',
    staging:      '.staging.candidly.com',
    development:  '.demo.localhost'
}.fetch(Rails.env.to_sym, :all)