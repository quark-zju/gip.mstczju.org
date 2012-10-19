# Shorten cookie key to make incoming traffic smaller

RailsNew::Application.config.session_store :active_record_store, :key => 's', expire_after: 2.years
