node[:deploy].each do |application, deploy|
    ruby_block "set full hostname" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/sysconfig/network")
      fe.search_file_replace_line(/HOSTNAME=#{node["opsworks"]["instance"]["hostname"]}/,"HOSTNAME=#{node["opsworks"]["instance"]["hostname"]}.mydomain.com")
    fe.write_file
  end
end

execute 'set current hostname' do
    command "hostname #{node["opsworks"]["instance"]["hostname"]}.mydomain.com"
end
end
