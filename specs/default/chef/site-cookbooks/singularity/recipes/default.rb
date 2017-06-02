#
# Cookbook:: singularity
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

%w{ cyclecloud thunderball }.each {|r| include_recipe r}

singularityver = node[:singularity][:version]

myplatform = node[:platform]
myplatform = "centos" if myplatform == "redhat" or myplatform == "amazon"

platform_version = node[:platform_version]
storedir = node[:thunderball][:storedir]

if myplatform == "centos"
  thunderball "singularity-#{singularityver}-0.1.el7.centos.x86_64.rpm" do
    url "/cycle/singularity-#{singularityver}-0.1.el7.centos.x86_64.rpm"
  end

  yum_package "singularity-#{singularityver}-0.1.el7.centos.x86_64.rpm" do
    source "#{storedir}/cycle/singularity-#{singularityver}-0.1.el7.centos.x86_64.rpm"
    action :install
  end
else
  thunderball "singularity-container_#{singularityver}-1_amd64.deb" do
    url "/cycle/singularity-container_#{singularityver}-1_amd64.deb"
  end

  dpkg_package "singularity-container_#{singularityver}-1_amd64.deb" do
    source "#{storedir}/cycle/singularity-container_#{singularityver}-1_amd64.deb"
    action :install
  end
end
