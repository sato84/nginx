#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
package 'epel-release'

package 'nginx'

service 'nginx' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

template '/usr/share/nginx/html/index.html' do
  source 'index.html.erb'
  mode '0644'
end

directory '/etc/nginx' do
  owner 'root'
  group 'root'
  mode 0755
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  notifies :reload, 'service[nginx]', :immediately
end

template '/etc/nginx/conf.d/default.conf' do
  source 'default.conf.erb'
  notifies :reload, 'service[nginx]', :immediately
end
