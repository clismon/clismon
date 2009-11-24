# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_clismon_session',
  :secret      => 'dee1eb69f7c62c2eb9b54df245e9b7b333d056e7957176731820f073feaf68ec918c6c0b4eafa81966cdf10f54954a054ec3b8987cba6303cf600011707c3170'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
