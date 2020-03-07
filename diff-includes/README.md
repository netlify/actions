# Diff Includes Filter for GitHub Actions

This action includes a filter to stop workflows unless certain files or directories are changed in a range of commits.

## Examples

```yml
on: push
name: Publish docs if changed
jobs:
  checkChangesInDocs:
    name: Check changes in docs
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@master

    - name: Check changes in stories
      uses: netlify/actions/diff-includes@master
      with:
        args: docs
```