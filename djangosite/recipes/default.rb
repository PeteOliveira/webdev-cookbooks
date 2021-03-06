include_recipe "djangosite::iptables"
include_recipe "djangosite::packages"

group "#{node.djangosite.name}" do
  action :create
end

user "#{node.djangosite.name}" do
  action :create
  comment "#{node.djangosite.name} site user"
  gid "#{node.djangosite.name}"
  home "/home/#{node.djangosite.name}"
  supports :manage_home => true
  shell ""
  password "!"
end

supervisor_service "#{node.djangosite.name}" do
  user "#{node.djangosite.name}"
  environment node.djangosite.supervisor.env
  directory "/home/#{node.djangosite.name}/project"
  command "#{node.supervisor_django.uwsgi.wrapper}"
  action :enable
  autostart true
  stopsignal "INT"
  startsecs 2
  stopwaitsecs 6
end

template "#{node.nginx.dir}/sites-available/#{node.djangosite.name}" do
  source "nginx_vhost.erb"
  mode "0644"
end

nginx_site "#{node.djangosite.name}"
