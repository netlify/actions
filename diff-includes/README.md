# Diff Includes Filter for GitHub Actions

This action includes a filter to stop workflows unless certain files or directories are changed in a range of commits.

## Examples

```yml
on: push
name: Publish docs if changed

jobs:
  checkChangesInDocs:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@master

    - name: Check changes in docs
      uses: netlify/actions/diff-includes@master
      with:
        # this can be one or many files/directories
        args: docs

  build:
    runs-on: ubuntu-latest

    steps:
    - name: Build
      needs: checkChangesInDocs
      # See https://github.com/netlify/actions/tree/master/build for details
      uses: netlify/actions/build@master
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}
        # this should match previous action `args` until known issue is resolved
        BUILD_DIR: docs
```