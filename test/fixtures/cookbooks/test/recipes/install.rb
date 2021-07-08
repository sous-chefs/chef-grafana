grafana_install 'grafana'

grafana_config 'Grafana' do
  # In test we turn of sensitive so we can get better logs
  sensitive false
end
grafana_config_alerting 'Grafana'
grafana_config_auth 'Grafana'
grafana_config_dashboards 'Grafana'
grafana_config_database 'Grafana'
grafana_config_dataproxy 'Grafana'
grafana_config_emails 'Grafana'
grafana_config_enterprise 'Grafana'
grafana_config_explore 'Grafana'
grafana_config_log 'Grafana'
grafana_config_metrics 'Grafana'
grafana_config_panels 'Grafana'
grafana_config_paths 'Grafana'
grafana_config_quota 'Grafana'
grafana_config_security 'Grafana'
grafana_config_server 'Grafana'
grafana_config_session 'Grafana' do
  session_provider :memory
end
grafana_config_remote_cache 'Grafana'
grafana_config_smtp 'Grafana'
grafana_config_snapshots 'Grafana'
grafana_config_users 'Grafana'
grafana_config_external_image_storage_s3 'Grafana' do
  storage_provider 's3'
  bucket 'grafana-image-store'
  region 'us-east-1'
end

# Tests are failing as the server has not fully become available when tests run
chef_sleep 'Sleep so inspec tests pass' do
  seconds 25
end

grafana_service 'grafana' do
  action %i(enable start)
end
