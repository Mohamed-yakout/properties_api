bundle install

rake db:create

psql properties_api_development < ./data/properties.sql

rake db:migrate
