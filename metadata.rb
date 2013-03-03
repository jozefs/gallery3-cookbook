name             "gallery"
maintainer       "Jozef Selesi"
maintainer_email "selesi@gmail.com"
license          "All rights reserved"
description      "Installs/Configures Gallery3 development environment"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

depends 'mysql', '~> 2.1.2'
depends 'database', '~> 1.3.12'
