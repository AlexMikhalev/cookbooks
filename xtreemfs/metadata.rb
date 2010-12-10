maintainer       "Alex Mikhalev"
maintainer_email "alex@sci-blog.com"
license          "All rights reserved - No guarantee it will work for you"
description      "Installs Xtreemfs server and client"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"   
depends          "java"
depends          "build-essential"  
%w{ ubuntu debian }.each do |os|
  supports os
end  

%w{ build-essential}.each do |cb|
  depends cb
end 
