#
# Author:: Barry Steinglass (<barry@opscode.com>)
# Cookbook Name:: movabletype
# Attributes:: movabletype
#
# Copyright 2009-2010, Opscode, Inc.
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
# General settings
set_unless[:movabletype][:version] = "5.02"
set_unless[:movabletype][:checksum] = "d2d8f399ab62b173077ae2980e9b72da"
set_unless[:movabletype][:dir] = "/var/www/movabletype"
set_unless[:movabletype][:db][:database] = "movabletypedb"
set_unless[:movabletype][:db][:user] = "movabletypeuser"

::Chef::Node.send(:include, Opscode::OpenSSL::Password)

set_unless[:movabletype][:db][:password] = secure_password
set_unless[:movabletype][:keys][:auth] = secure_password
set_unless[:movabletype][:keys][:secure_auth] = secure_password
set_unless[:movabletype][:keys][:logged_in] = secure_password
set_unless[:movabletype][:keys][:nonce] = secure_password
