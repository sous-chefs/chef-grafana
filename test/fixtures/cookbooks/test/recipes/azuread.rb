grafana_install 'grafana'

grafana_config 'Grafana' do
  # In test we turn of sensitive so we can get better logs
  sensitive false
end

grafana_config_log 'Grafana'

grafana_config_auth_azuread 'Grafana' do
  auth_name 'Test Azure AD'
  enabled true
  allow_sign_up true
  client_id 'test_id'
  client_secret 'test_secret'
  auth_url 'https://login.microsoftonline.com/12345/oauth2/authorize'
  token_url 'https://login.microsoftonline.com/12345/oauth2/token'
  scopes 'openid email name groups'
  allowed_domains 'test.local'
  allowed_groups '12345'
end

# Tests are failing as the server has not fully become available when tests run
chef_sleep 'Sleep so inspec tests pass' do
  seconds 25
end

grafana_service 'grafana' do
  action %i(enable start)
end
