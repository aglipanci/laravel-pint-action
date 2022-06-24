# GitHub Action for Laravel Pint  

GitHub Action implementation of the [Laravel Pint](https://github.com/laravel/pint) Package. 

## Usage

Use with [GitHub Actions](https://github.com/features/actions)

_.github/workflows/pint.yml_

```
name: PHP Linting
on: pull_request
jobs:
  phplint:
    runs-on: ubuntu-latest
    steps:
        - uses: actions/checkout@v1
        - uses: aglipanci/laravel-pint-action@main
```

If provided, a `pint.json` file in the root will be used for configuration during run of the Action.