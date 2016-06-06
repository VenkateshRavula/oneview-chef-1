################################################################################
# (C) Copyright 2016 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

client = {
  url: '',
  user: '',
  password: '',
  ssl_enabled: false
}

oneview_enclosure_group 'Eg2' do
  data ({
    stackingMode: 'Enclosure',
    interconnectBayMappingCount: 8
  })
  logical_interconnect_group 'lig1'
  client client
  action :create
end

oneview_enclosure_group 'Eg2' do
  client client
  action :delete
end
