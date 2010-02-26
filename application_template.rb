# Copyright (c) 2009-2010 Midwire Technologies, LLC
 
# Plugins
plugin 'exception_notifier', :git => 'git://github.com/rails/exception_notification.git'
plugin 'annotate_models', :svn => 'http://repo.pragprog.com/svn/Public/plugins/annotate_models'

# Gems
if yes?("Will you need to paginate?")
  gem "mislav-will_paginate", :lib => 'will_paginate'
end

if yes?("Do You need AASM?")
  gem 'aasm'
end

if yes?("Do You need active_merchant?")
  gem 'activemerchant', :lib => "active_merchant"
end
rake("gems:install", :sudo => true)
 
# Generators
generate :app_layout
if yes?("Will you be using MySQL?")
  db_password = ask("What is the MySQL password for root?")
  puts "Type 'y' and Enter to overwrite the current database.yml file."
  generate( "database_yml_mysql #{db_password}")
end
if yes?("Do you need Authlogic?")
  generate :authlogic # dependency:
end
if yes?("Do you need attachment_fu?")
  plugin 'attachment_fu', :git => 'git://github.com/technoweenie/attachment_fu.git'
end

if yes?("Do You need paperclip?")
  plugin 'paperclip', :git => 'git://github.com/thoughtbot/paperclip.git'
end
if yes?("Do You need restful_authentication?")
  plugin 'restful_authentification', :git => 'git://github.com/technoweenie/restful-authentication.git'
end


if yes?("Do You need auto_complete?")
  plugin 'auto_complete', :git => 'git://github.com/rails/auto_complete.git'
end
if yes?("Do You need seo_urls?")
  plugin 'seo_urls', :svn => 'http://svn.redshiftmedia.com/svn/plugins/seo_urls'
end


generate :controller, "home index"
route "map.root :controller => :home"
 
# General cleanup
rake "db:create:all"
rake "db:migrate"
run "echo TODO > README"
run "rm -f public/index.html"

#freeze rails and unpack gems
rake "rails:freeze:gems"
rake "gems:unpack"
 
# Files
file ".gitignore", <<-END
.DS_Store
log/*.log
log/*.pid
tmp/**/*
config/database.yml
db/*.sqlite3
END
 
# Git
git :init
git :add => "."
git :commit => "-m 'initial commit'"