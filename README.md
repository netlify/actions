# GitHub Actions for Netlify

This repository contains GitHub Actions for Netlify, for performing common tasks such as triggering a site deploy, as well as a generic cli for doing arbitrary actions with the netlify commandline client.

## Usage
Usage information for individual commands can be found in their respective directories.

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
