#
# Cookbook Name:: elasticsearch-cluster
# Recipe:: install
#
# Copyright 2015, Virender Khatri
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

fail "invalid value for node attribute node['elasticsearch']['install_method'], valid are 'package tarball'" unless %w(package tarball).include?(node['elasticsearch']['install_method'])

include_recipe 'elasticsearch-cluster::java'

[node['elasticsearch']['data_dir'],
 node['elasticsearch']['log_dir'],
 node['elasticsearch']['work_dir']
].each do |dir|
  directory dir do
    owner node['elasticsearch']['user']
    group node['elasticsearch']['group']
    mode node['elasticsearch']['mode']
    recursive true
  end
end

include_recipe "elasticsearch-cluster::#{node['elasticsearch']['install_method']}"
