# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_Tests_app_api_session'
TestsAppApi::Application.config.session_store :active_record_store