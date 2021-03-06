#
# Cookbook Name:: oneview_test
# Recipe:: power_device_set_uid_state_on
#
# (c) Copyright 2017 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.
#

oneview_power_device 'PowerDeviceUidStateOn' do
  client node['oneview_test']['client']
  uid_state 'on'
  action :set_uid_state
end
