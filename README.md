[![Build Status](https://travis-ci.org/kalleth/monytr-core.svg?branch=master)](https://travis-ci.org/kalleth/monytr-core) 
[![Code Climate](https://codeclimate.com/github/kalleth/monytr-core.png)](https://codeclimate.com/github/kalleth/monytr-core)

# Monytr-core
Monytr-core is a background process that performs simple up/down monitoring for your websites. It's intended to be extended with a web UI in future, but works perfectly well as-is.

Monytr-core is designed to be used on an external low end VPS, outside of your usual hosting environment.

It notifies you via configurable responders -- i.e., provide a path for it to check (see config/checks.yml) and if that path returns anything other than a '200' response, you'll get an e-mail (if you've configured an e-mail responder).

## Integrations
 * Hipchat
 * Email
 * Slack (beta)

To set up integrations, see config/checks.yml and config/config.yml.example.

## Monytr-core is not a persistent data store
That means it won't store average ping responses, error rates, and the like. If you need that, go pay for one of the more featureful tools -- pingdom, newrelic et al. -- they are much better tools for this.

## Running monytr-core
1. Install dependency 'redis'. Monytr expects redis to be running locally on a default port. This is used to store the last few checks so Monytr can detect state changes and flapping sites. `apt-get install redis-server` or `brew install redis`.
2. Install gems: `$ bundle install`
3. Copy config file, and then edit it: `$ cp config/config.yml.example config/config.yml; vim config/config.yml`
4. Set up your checks: `$ vim config/checks.yml`
5. Run the app: `$ foreman start`

If you want e-mails to open in your browser while developing, then set
environment variable `RUBY_ENV` to "development" (uses letter_opener gem)

## HOW DO I SHOT TEST?!
Follow above, then instead of starting the app:
`$ rspec`

## Pull request?
Please.

## License?
MIT. See [LICENSE.md](LICENSE.md)
