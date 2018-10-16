# Diff Includes Filter for GitHub Actions

This action includes a filter to stop workflows unless certain files or directories are changed in a range of commits.

## Examples

```hcl
workflow "Publish docs if changed" {
  on = "push"
  resolves = ["Publish"]
}

action "Check changes in docs" {
  uses = "netify/actions/diff-includes@master"
  // this can be one or many files/directories
  args = "docs"
}

// This will only be run if there are changes in docs directory in the last set
// of commits pushed
action "Publish" {
  needs = "Checks changes in docs"
  uses = "netlify/actions/build@master"
  // see https://github.com/netlify/actions/tree/master/build for details
  secrets = ["GITHUB_TOKEN", "NETLIFY_SITE_ID"]
}
```
