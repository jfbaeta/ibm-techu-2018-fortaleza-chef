package 'httpd' do
  action :install
end

service 'httpd' do
  action [:enable, :start]
end

%w{dev qa prod}.each do |ambiente|

  directory "/var/www/#{ambiente}.ibmtechu2018.com.br/public_html" do
    mode "0755"
    owner "root"
    group "root"
    recursive true
    action :create
  end

  template "/var/www/#{ambiente}.ibmtechu2018.com.br/public_html/index.html" do
    source "index.erb"
    variables ({:ambiente => ambiente})
    action :create
  end

end

directory "/etc/httpd/sites-available" do
  mode "0755"
  owner "root"
  group "root"
  recursive true
  action :create
end

directory "/etc/httpd/sites-enabled" do
  mode "0755"
  owner "root"
  group "root"
  recursive true
  action :create
end

bash "insert_line" do
  user "root"
  code <<-EOS
  echo "IncludeOptional sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf
  EOS
  not_if "grep -q IncludeOptional /etc/httpd/conf/httpd.conf"
end

%w{dev qa prod}.each do |ambiente|

  template "/etc/httpd/sites-available/#{ambiente}.ibmtechu2018.com.br.conf" do
    source "virtualhost.erb"
    variables ({:ambiente => ambiente})
    action :create
  end
  
  execute "link" do
    command "ln -s /etc/httpd/sites-available/#{ambiente}.ibmtechu2018.com.br.conf /etc/httpd/sites-enabled/#{ambiente}.ibmtechu2018.com.br.conf"
    action :run
  end

end

service 'httpd' do
  action [:restart]
end
