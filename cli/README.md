# GitHub Actions for Netlify CLI

This Action enables arbitrary actions with the [Netlify CLI](https://github.com/netlify/cli)

## Secrets
- `NETLIFY_AUTH_TOKEN` - *Required* The token to use for authentication.
  [Obtain one with the UI](https://www.netlify.com/docs/cli/#obtain-a-token-in-the-netlify-ui)
- `NETLIFY_SITE_ID` - *Optional* API site ID of the site you wanna work on
  [Obtain it from the UI](https://www.netlify.com/docs/cli/#link-with-an-environment-variable)

## Example

```yml
on: push
name: Publish on Netlify
jobs:
  publish:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@master

    - name: Publish
      uses: netlify/actions/cli@master
        with:
          args: deploy --dir=site --functions=functions
      env:
        NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}
        NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
```