# Simoom -- the internal planning tool of Screen Concept

## Setup Instructions

- copy `config/database.yml.sample` to `config/database.yml` and edit
  according to your needs

- copy `config/application.yml.sample` to `config/application.yml` and edit
  according to your needs

- `bundle install`

- `rake db:migrate`

- run `Basecamp::Importer.perform` to sync with your basecamp account

## Synchronization with Basecamp

For synchronization with basecamp, use `Basecamp::Importer.perform`.
This will update existing records and create new ones.
