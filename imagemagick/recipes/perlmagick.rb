#
# Cookbook Name:: imagemagick
# Recipe:: perlmagick
#
# Copyright 2009, Opscode, Inc.
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
include_recipe "imagemagick"

case node[:platform]
when "redhat", "centos", "fedora"
  package "ImageMagick-devel"
when "debian", "ubuntu"
  package "libmagickwand-dev"
end

Chef::Log.info("Installing Image Magick via apt")

# # Install perlmagick properly??
package "perlmagick" do
  case node[:platform]
  when "centos","redhat","fedora","suse"
    package_name "ImageMagick-perl"
  when "debian","ubuntu"
    package_name "perlmagick"
  end
  action :install
end    
