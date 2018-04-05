#
# Cookbook:: singularity
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


VERSION = node['singularity']['version']

myplatform = node[:platform]
myplatform = "centos" if myplatform == "redhat" or myplatform == "amazon"
platform_version = node[:platform_version]

# TODO : First check if pre-built packages exist
#      : Need to figure out rpm and deb package naming

# if myplatform == "centos"
#   jetpack_download "singularity-#{VERSION}-0.1.el7.centos.x86_64.rpm" do
#     project "singularity"
#     not_if { ::File.exist?("#{node[:jetpack][:downloads]}/singularity-#{VERSION}-0.1.el7.centos.x86_64.rpm") }
#   end
#
#   yum_package "singularity-#{VERSION}-0.1.el7.centos.x86_64.rpm" do
#     source "#{node[:jetpack][:downloads]}/singularity-#{VERSION}-0.1.el7.centos.x86_64.rpm"
#     action :install
#   end
# else
#   jetpack_download "singularity-container_#{VERSION}-1_amd64.deb" do
#     project "singularity"
#     not_if { ::File.exist?("#{node[:jetpack][:downloads]}/singularity-container_#{VERSION}-1_amd64.deb") }
#   end
#
#   dpkg_package "singularity-container_#{VERSION}-1_amd64.deb" do
#     source "#{node[:jetpack][:downloads]}/singularity-container_#{VERSION}-1_amd64.deb"
#     action :install
#   end
# end

# ELSE build from source
include_recipe 'build-essential'
jetpack_download "singularity-#{VERSION}.tar.gz" do
  project "singularity"
  not_if { ::File.exist?("#{node[:jetpack][:downloads]}/singularity-#{VERSION}.tar.gz") }
end


bash 'make singularity' do
  cwd "/tmp"
  code <<-EOH
       tar xzvf #{node[:jetpack][:downloads]}/singularity-#{VERSION}.tar.gz
       cd singularity-#{VERSION}
       ./configure --prefix=/usr/local
       make
       make install
       EOH
  not_if { ::File.exist?("/usr/local/libexec/singularity") }
end

