name              "djangosite"
maintainer        "Mikhail Kolesnik"
maintainer_email  "mike@openbunker.org"
description       "Configures host to run a Django site"
version           "0.0.1"

recipe "djangosite", "Creates Nginx virtual host for a Django site, enables it. Also creates and enables Supervisor 'program' to run the site."


%w{ ubuntu debian }.each do |os|
  supports os
end

depends 'apt'
depends 'nginx'
depends 'supervisor'
depends 'supervisor_django'
depends 'simple_iptables'

attribute "djangosite/name",
  :display_name => "Django site name",
  :description => "A unique name to use for Nginx virtual host and Supervisor program",
  :default => ""

attribute "djangosite/domains",
  :display_name => "Django site domain names",
  :description => "A domain names to use in Nginx virtual host",
  :type => "array",
  :default => []

attribute "djangosite/package",
  :display_name => "Django site package name",
  :description => "A Python package name to use in Nginx virtual host paths, is not required if matches the djangosite/name",
  :default => ""

attribute "djangosite/client_max_body_size",
  :display_name => "Nginx client_max_body_size option",
  :description => "Set this to override Nginx's 'http' context value for this option",
  :default => "8M"

attribute "djangosite/supervisor/env",
  :display_name => "Supervisor environment as a hash use for running Django site instance",
  :description => "Set this to override defaults in uwsgi_django.sh provided by supervisor_django cookbook",
  :default => ""

attribute "djangosite/http_ports",
  :display_name => "HTTP ports",
  :description => "HTTP ports to open in the firewall",
  :type => "array",
  :default => [80]

attribute "djangosite/packages",
  :display_name => "A list of packages to install",
  :type => "array",
  :default => ['git', 'mercurial', 'subversion', 'libmemcached-dev', 'libxml2', 'libxslt1-dev',
               'graphicsmagick', 'libjpeg-dev', 'libpng-dev', 'libfreetype6-dev']

attribute "djangosite/extra_packages",
  :display_name => "A list of extra packages to install",
  :type => "array",
  :default => []

