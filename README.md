## README

This README would normally document whatever steps are necessary to get the
application up and running.

In rails 5, belongs_to relationships are always validated for presence unless 'optional'.
find the ER diagram under 'doc'

ruby '2.2.2'

After 'bundle install', run:
1) bin/rails db:environment:set RAILS_ENV=development
2) bundle exec rake db:drop db:create db:migrate db:seed tmp:clear log:clear --trace
