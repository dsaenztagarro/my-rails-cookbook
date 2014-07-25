name             'my-rails'
maintainer       'YOUR_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures doventia-rb'
long_description 'Installs/Configures doventia-rb'
version          '0.1.0'

# Fetching dependencies can fail from time to time due to the fact that
# Berkshelf API service is unavailable. To check status:
# https://api.berkshelf.com/status

# Environment
depends 'my-environment'

# Database
depends 'postgresql'
depends 'mysql'
depends 'database'
depends 'sphinx'

# Backend
depends 'rvm'
depends 'nodejs'

depends 'redis'
