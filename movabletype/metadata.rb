maintainer       "Alex Mikhalev"
maintainer_email "alex@sci-blog.com"
license          "Apache 2.0"
description      "Installs/Configures movable type - derivative from movabletype cookbook"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1"
depends          "build-essential"
depends          "php"
depends          "perl"
depends          "apache2"
depends          "mysql"
depends          "openssl"
depends           "imagemagick"
depends           "xml"
depends           "apt"

%w{ debian ubuntu }.each do |os|
  supports os
end


attribute "movabletype/version",
  :display_name => "MovableType download version",
  :description => "Version of MovableType to download from the MovableType site.",
  :default => "5.02"
  
attribute "movabletype/checksum",
  :display_name => "MovableType tarball checksum",
  :description => "Checksum of the tarball for the version specified.",
  :default => "d2d8f399ab62b173077ae2980e9b72da"
  
attribute "movabletype/dir",
  :display_name => "MovableType installation directory",
  :description => "Location to place movabletype files.",
  :default => "/var/www"
  
attribute "movabletype/db/database",
  :display_name => "MovableType MySQL database",
  :description => "MovableType will use this MySQL database to store its data.",
  :default => "movabletypedb"

attribute "movabletype/db/user",
  :display_name => "MovableType MySQL user",
  :description => "MovableType will connect to MySQL using this user.",
  :default => "movabletypeuser"

attribute "movabletype/db/password",
  :display_name => "MovableType MySQL password",
  :description => "Password for the Wordpress MySQL user.",
  :default => "randomly generated"

attribute "movabletype/keys/auth",
  :display_name => "MovableType auth key",
  :description => "MovableType auth key.",
  :default => "randomly generated"

attribute "movabletype/keys/secure_auth",
  :display_name => "MovableType secure auth key",
  :description => "MovableType secure auth key.",
  :default => "randomly generated"

attribute "movabletype/keys/logged_in",
  :display_name => "MovableType logged-in key",
  :description => "MovableType logged-in key.",
  :default => "randomly generated"

attribute "movabletype/keys/nonce",
  :display_name => "MovableType nonce key",
  :description => "MovableType nonce key.",
  :default => "randomly generated"
  
