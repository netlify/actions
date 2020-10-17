# GitHub Actions for Netlify CLI

This Action enables arbitrary actions with the [Netlify CLI](https://github.com/netlify/cli)

## Secrets
- `NETLIFY_AUTH_TOKEN` - *Required* The token to use for authentication.
  [Obtain one with the UI](https://www.netlify.com/docs/cli/#obtain-a-token-in-the-netlify-ui)
- `NETLIFY_SITE_ID` - *Optional* API site ID of the site you wanna work on
  [Obtain it from the UI](https://www.netlify.com/docs/cli/#link-with-an-environment-variable)
  
## Outputs

The following outputs will be available from a step that uses this action:
- `NETLIFY_OUTPUT`, the full stdout from the run of the `netlify` command
- `NETLIFY_URL`, the URL of the draft site that Netlify provides
- `NETLIFY_LOGS_URL`, the URL where the logs from the deploy can be found
- `NETLIFY_LIVE_URL`, the URL of the "real" site, set only if `--prod` was passed

See [the documentation](https://docs.github.com/en/free-pro-team@latest/actions/reference/context-and-expression-syntax-for-github-actions) for info and examples of how to use outputs in later steps and jobs.

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
