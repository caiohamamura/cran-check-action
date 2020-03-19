# cran-check-action
CRAN-like check action for github

## Example Usage
To get this action running in your project, add the following config to .github/workflows/Rbuild.yml:
```yml
name: R Build and Checks
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: R Build and Checks
      uses: caiohamamura/cran-check-action@v0.0.1
```
