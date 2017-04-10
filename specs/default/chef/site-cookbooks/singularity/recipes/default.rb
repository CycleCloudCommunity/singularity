#
# Cookbook:: singularity
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

%w{ cyclecloud thunderball }.each {|r| include_recipe r}

singularityver = node[:singularity][:version]

storedir = node[:thunderball][:storedir]
thunderball "singularity-#{singularityver}.x86_64.rpm" do
  url "/cycle/singularity-#{singularityver}.x86_64.rpm"
end

yum_package "singularity-#{singularityver}.x86_64.rpm" do
  source "#{storedir}/cycle/singularity-#{singularityver}.x86_64.rpm"
  action :install
end
