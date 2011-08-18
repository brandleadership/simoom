# Simoom -- the internal planning tool of Screen Concept

## Setup Instructions

- copy `config/database.yml.sample` to `config/database.yml` and edit
  according to your needs

- copy `config/application.yml.sample` to `config/application.yml` and edit
  according to your needs

- `bundle install`

- `rake db:migrate`

- run `script/rails runner 'Basecamp::Importer.perform'` to sync with your basecamp account

## Synchronization with Basecamp

- run `script/rails runner 'Basecamp::Importer.perform'` to sync with your basecamp account

- to get debug messages, use the :debug flag: `Basecamp::Importer.perform(:debug)`

## Development

- use `bundle exec rake` to run all specs

- use `bundle exec guard -c` for BDD
