[![Build Status](https://travis-ci.org/kalleth/monytr-core.svg?branch=master)](https://travis-ci.org/kalleth/monytr-core) 
[![Code Climate](https://codeclimate.com/github/kalleth/monytr-core.png)](https://codeclimate.com/github/kalleth/monytr-core)

# Monytr-core
Monytr-core is a background process that performs simple up/down monitoring for your websites. It's intended to be extended with a web UI in future, but works perfectly well as-is.

Monytr-core is designed to be used on an external low end VPS, outside of your usual hosting environment.

It notifies you via Hipchat and E-mail -- i.e., provide a path for it to check (see config/checks.yml) and if that path returns anything other than a '200' response, you'll get an e-mail.

## Running monytr-core
1. Install gems: `$ bundle install`
2. Copy config file, and then edit it: `$ cp config/config.yml.example config/config.yml; vim config/config.yml`
3. Set up your checks: `$ vim config/checks.yml`
4. Run the app: `$ foreman start`

If you want e-mails to open in your browser while developing, then set
environment variable `RUBY_ENV` to "development" (uses letter_opener gem)

## HOW DO I SHOT TEST?!
Follow above, then instead of starting the app:
`$ rspec`

## Pull request?
Please.

## License?
MIT. See [LICENSE.md](LICENSE.md)
