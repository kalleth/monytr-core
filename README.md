[![Build Status](https://travis-ci.org/kalleth/monytr-core.svg?branch=master)](https://travis-ci.org/kalleth/monytr-core)

# Monytr-core
Monytr-core is the backend/processing component of [Monytr](https://github.com/kalleth/monytr).

It can be used without a web frontend (to be developed) to notify you via Hipchat and E-mail when your sites go down -- i.e., provide a path for it to check (see config/checks.yml) and if that path returns anything other than a '200' response, you'll get an e-mail.

## WTF IS: Monytr?
Monytr is a single-purpose application designed to do one thing well. Tell you when your websites go down.

## A note for people
Some of this code is messy, and somewhat poor, and I'll refactor it to be high-quality once the app is released and working. This is code for me, not clients, at the moment. If you are an agent or anyone looking to hire me, remember [github is not my CV](https://blog.jcoglan.com/2013/11/15/why-github-is-not-your-cv/) and you shouldn't use this repository to influence your decision. Yet.

## HOW DO I RUN TEH APP
1. Install gems: `$ bundle install`
2. Copy config file, and then edit it: `$ cp config/config.yml.example config/config.yml; vim config.config.yml`
3. Set up your checks: `$ vim config/checks.yml`
4. Run the app: `$ foreman start`

If you want e-mails to open in your browser while developing, then set
environment variable `RUBY_ENV` to "development" (uses letter_opener gem)

## HOW DO I SHOT TEST?!
Follow above, then instead of starting the app:
`$ rspec`

## Pull request?
SCHTOP. WHAT ARE YOU DOING? On github, we only let you contribute, after the first release.

## License?
MIT. See [LICENSE.md](LICENSE.md)
