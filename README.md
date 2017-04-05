# Nag

> The mother-in-law of linters

A microservice to nag you about code quality; [Pronto](https://github.com/mmozuras/pronto)-as-a-Service.

## Lifecycle

![Life cycle](lifecycle.png)

Pronto does not yet support Java but that's something we can contribute! Pronto runners wrap any CLI tool and normalize the output, there are three tools to consider for future incorporation:

- [Findbugs](http://findbugs.sourceforge.net) — Identify existing bugs.
- [PMD](https://pmd.github.io) — Code quality, anti-patterns, error prone code.
- [Checkstyle](http://checkstyle.sourceforge.net) — Styleguide enforcement.

## Running Locally

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
