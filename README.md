# Decidim::Accountability

[![Build Status](https://www.travis-ci.org/decidim/decidim-accountability.svg?branch=master)](https://www.travis-ci.org/decidim/decidim-accountability)


The Accountability module adds results to any participatory process. It adds a CRUD engine to the admin and public views scoped inside the participatory process. Accountability will link to related meetings and proposals and will be used to show the progress on the related proposals.

It also has a CSV importer for results, you can read [here](doc/csv_importer.md) about how it works, the CSV columns and what they mean.

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

## Migration from `Decidim::Results` module
To migrate results from Decidim::Results to Decidim::Accountability you can use a rake task like [this one in decidim-barcelona](https://github.com/PopulateTools/decidim-barcelona/blob/accountability/lib/tasks/migrate_results_to_accountability.rake). The task asumes that the accountability feature for the process has already been created. It takes a process ID as an argument, and defaults to 1 if none is provided:
```bash
$ bundle exec rake migrate:results_to_accountability[PROCESS_ID]
``` 


## Local development setup
Clone [decidim-barcelona](https://github.com/PopulateTools/decidim-barcelona), at the same directory level as this `decidim-accountability` clone, and then checkout the `accountability-localdev` branch.

Inside the `decidim-barcelona` directory run:

- `bundle exec rake db:setup`
- `bundle exec rake test_data:load`

Now you should be able to start a local server with `bundle exec rails s`.

## Contributing
See [Decidim](https://github.com/AjuntamentdeBarcelona/decidim).

## License
See [Decidim](https://github.com/AjuntamentdeBarcelona/decidim).
