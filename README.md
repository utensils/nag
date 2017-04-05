# Nag [![Build Status](https://travis-ci.org/doomspork/nag.svg?branch=master)](https://travis-ci.org/doomspork/nag)

> The mother-in-law of linters

A microservice to nag you about code quality; [Pronto](https://github.com/mmozuras/pronto)-as-a-Service.

## Lifecycle

![Life cycle](lifecycle.png)

## Deploying

Nag is built to work with releases, courtesy of [Distillery](https://github.com/bitwalker/distillery).  To build a new release:

```shell
$ MIX_ENV=prod mix release --env=prod
==> Assembling release..
==> Building release nag:1.1.0 using environment prod
==> Including ERTS 8.2 from /usr/lib/erlang/erts-8.2
==> Packaging release..
==> Release successfully built!
    You can run it in one of the following ways:
      Interactive: _build/prod/rel/nag/bin/nag console
      Foreground: _build/prod/rel/nag/bin/nag foreground
      Daemon: _build/prod/rel/nag/bin/nag start
```

_Note_: The current configuration includes the ERTS so releases must be built on the same architecture they are targetting; the included Dockerfile can be used for building Ubuntu releases:

```shell
$ docker build --tag=elixir-build .
$ docker run -v ~/Projects/nag/releases:/app/_build/prod/rel elixir-build mix release --env=prod
```

## Testing Nag locally

As it stands today, Nag relies on GitHub webhooks to know when and what to analyze.  During local development [Postman](https://getpostman.com) (or any REST  client) can be used to fake webhook requests to our local Nag server.  Local requests should target [localhost:4000/webhook](http://localhost:4000/webhook).

There are only a handful of fields required by Nag so a minimal request without those values will suffice:

```json
{
  "action": "opened",
  "pull_request": {
    "number": 1,
    "state": "open",
    "head": {
      "ref": "branch-name",
      "repo": {
        "full_name": "wombatsecurity/repo-name"
      }
    }
  }
}
```
