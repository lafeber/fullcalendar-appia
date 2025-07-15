
# Async remote events from the ONS suite

We use a local openapi server in the Procfile to generate a server built from consuming.yml

![Screenshot](screenshot.png)

The fullcalendar backend code is a bit hacky / vibe coded,
that's not the purpose of this repo.

## Why this and not amoretto?

* amoretto yml files are static copies, not in sync with openapi spec
* appia bot keeps yml files up to date
* you get errors when e.g. you call an endpoint without required parameters
* no duplication

## Start

* `/bin/setup`
* `/bin/dev`
* Go to `http://localhost:3000` to view calendar or `http://localhost:9000/openapi.json`
to check your remote server!

## TODO

* Dates in schemas are currently static
* Nice mocks for spec / test
* Add urls for staging / production
