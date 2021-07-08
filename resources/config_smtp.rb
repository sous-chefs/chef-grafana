#
# Cookbook:: grafana
# Resource:: config_smtp
#
# Copyright:: 2018, Sous Chefs
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Configures the installed grafana instance

unified_mode true

use 'partial/_config_file'

property  :instance_name,   String,         name_property: true
property  :enabled,         [true, false],  default: false
property  :host,            String,         default: 'localhost:25'
property  :user,            String,         default: ''
property  :password,        String,         default: ''
property  :cert_file,       String,         default: ''
property  :key_file,        String,         default: ''
property  :skip_verify,     [true, false],  default: false
property  :from_address,    String,         default: "admin@grafana-#{node['hostname']}.#{node['domain'].nil? ? 'local' : node['domain']}"
property  :from_name,       String,         default: 'Grafana'
property  :ehlo_identity,   String,         default: ''

action_class do
  include GrafanaCookbook::ConfigHelper
end

action :install do
  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    run_state_config_set(rp.to_s, new_resource.send(rp))
  end
end
