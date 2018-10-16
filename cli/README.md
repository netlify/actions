# GitHub Actions for Netlify CLI

This Action enables arbitrary actions with the [Netlify CLI](https://github.com/netlify/cli)

## Secrets
- `NETLIFY_AUTH_TOKEN` - *Required* The token to use for authentication.
  [Obtain one with the UI](https://www.netlify.com/docs/cli/#obtain-a-token-in-the-netlify-ui)
- `NETLIFY_SITE_ID` - *Optional* API site ID of the site you wanna work on
  [Obtain it from the UI](https://www.netlify.com/docs/cli/#link-with-an-environment-variable)


## Example

```hcl
workflow "Publish on Netlify" {
  on = "push"
  resolves = ["Publish"]
}

action "Publish" {
  uses = "netlify/actions/cli@master"
  args = "deploy --dir=site --functions=functions"
  secrets = ["NETLIFY_AUTH_TOKEN", "NETLIFY_SITE_ID"]
}
```
