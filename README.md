# Decidim::Accountability

[![Build Status](https://www.travis-ci.org/decidim/decidim-accountability.svg?branch=master)](https://www.travis-ci.org/decidim/decidim-accountability)


The Accountability module adds results to any participatory process. It adds a CRUD engine to the admin and public views scoped inside the participatory process. Accountability will link to related meetings and proposals and will be used to show the progress on the related proposals.

## Usage
Accountability will be available as a Feature for a Participatory Process.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'decidim-accountability'
```

And then execute:
```bash
$ bundle
```

## Test setup
First, clone [decidim-barcelona](https://github.com/PopulateTools/decidim-barcelona). Afterwards, come back to the `decidim-accountability` folder and run the following commands:

- `bundle install`
- `bundle exec rake`
- `cd spec/decidim-accountability_dummy_app  && bundle exec rake db:setup`
- `cp ../../../decidim-barcelona/lib/tasks/test_data.rake lib/tasks/ && cp ../../../decidim-barcelona/action_plans.csv .`
- `bundle exec rake test_data:load`

Now you should be able to start a local server with `bundle exec rails s`.

## Contributing
See [Decidim](https://github.com/AjuntamentdeBarcelona/decidim).

## License
See [Decidim](https://github.com/AjuntamentdeBarcelona/decidim).
