---
name: gh-pr-review
description: View and manage inline GitHub PR review comments with full thread context from the terminal
---

# How to use the GitHub API to Handle pull request reviews

## Required Tools

- GitHub CLI

## Steps

1. Use the _list reviews for a pull request_ endpoint to List existing PRs submitted
   by me by me and get the ID
2. For every PR, use the _list comments for a pull request review_
   endpoint to retrieve the comments for the PR. As part of your code review,
   ensure they were handled correctly. If you find any comments that were not
   handled correctly, use the _create a reply for a review comment_ endpoint to
   reply to the comment and ask for clarification or suggest a change.
3. Review the code in the PR, normally it would already be checked out to the
   current directory and collect the comments you want to make.
4. For replys, use the _create a reply for a review comment_ endpoint to
   reply to the comment and ask for clarification or suggest a change.
5. For new comments, use the _create a review for a pull request_
   endpoint to create a review with the comments you want to make.
   Make sure you keep the event part blank so that the review is created
   in the `PENDING` state.
6. To submit the review, use the _submit a review for a pull request_ endpoint
   to submit the review and set the event to either `APPROVE`,
   `REQUEST_CHANGES`, or `COMMENT` depending on the outcome of your code review.

## Endpoints

- List reviews for a pull request - `GET /repos/{owner}/{repo}/pulls/{pull_number}/reviews`
- List review comments on a pull request - `GET /repos/{owner}/{repo}/pulls/{pull_number}/comments`
- Create a reply for a review comment - `POST /repos/{owner}/{repo}/pulls/{pull_number}/comments/{comment_id}/replies`
- Create a review for a pull request - `POST /repos/{owner}/{repo}/pulls/{pull_number}/reviews`
- Submit a review for a pull request - `POST /repos/{owner}/{repo}/pulls/{pull_number}/reviews/{review_id}/events`

## How to use the GitHub API to Handle pull request reviews with GitHub CLI

### General Help

Makes an authenticated HTTP request to the GitHub API and prints the response.

The endpoint argument should either be a path of a GitHub API v3 endpoint, or
`graphql` to access the GitHub API v4.

Placeholder values `{owner}`, `{repo}`, and `{branch}` in the endpoint
argument will get replaced with values from the repository of the current
directory or the repository specified in the `GH_REPO` environment variable.
Note that in some shells, for example PowerShell, you may need to enclose
any value that contains `{...}` in quotes to prevent the shell from
applying special meaning to curly braces.

The `-p/--preview` flag enables opting into previews, which are feature-flagged,
experimental API endpoints or behaviors. The API expects opt-in via the `Accept`
header with format `application/vnd.github.<preview-name>-preview+json` and this
command facilitates that via `--preview <preview-name>`. To send a request for
the corsair and scarlet witch previews, you could use `-p corsair,scarlet-witch`
or `--preview corsair --preview scarlet-witch`.

The default HTTP request method is `GET` normally and `POST` if any parameters
were added. Override the method with `--method`.

Pass one or more `-f/--raw-field` values in `key=value` format to add static string
parameters to the request payload. To add non-string or placeholder-determined values, see
`-F/--field` below. Note that adding request parameters will automatically switch the
request method to `POST`. To send the parameters as a `GET` query string instead, use
`--method GET`.

The `-F/--field` flag has magic type conversion based on the format of the value:

- literal values `true`, `false`, `null`, and integer numbers get converted to
  appropriate JSON types;
- placeholder values `{owner}`, `{repo}`, and `{branch}` get populated with values
  from the repository of the current directory;
- if the value starts with `@`, the rest of the value is interpreted as a
  filename to read the value from. Pass `-` to read from standard input.

For GraphQL requests, all fields other than `query` and `operationName` are
interpreted as GraphQL variables.

To pass nested parameters in the request payload, use `key[subkey]=value` syntax when
declaring fields. To pass nested values as arrays, declare multiple fields with the
syntax `key[]=value1`, `key[]=value2`. To pass an empty array, use `key[]` without a
value.

To pass pre-constructed JSON or payloads in other formats, a request body may be read
from file specified by `--input`. Use `-` to read from standard input. When passing the
request body this way, any parameters specified via field flags are added to the query
string of the endpoint URL.

In `--paginate` mode, all pages of results will sequentially be requested until
there are no more pages of results. For GraphQL requests, this requires that the
original query accepts an `$endCursor: String` variable and that it fetches the
`pageInfo{ hasNextPage, endCursor }` set of fields from a collection. Each page is a separate
JSON array or object. Pass `--slurp` to wrap all pages of JSON arrays or objects
into an outer JSON array.

For more information about output formatting flags, see `gh help formatting`.

**USAGE**
gh api <endpoint> [flags]

**FLAGS**
--cache duration Cache the response, e.g. "3600s", "60m", "1h"
-F, --field key=value Add a typed parameter in key=value format (use "@<path>" or "@-" to read value from file or stdin)
-H, --header key:value Add a HTTP request header in key:value format
--hostname string The GitHub hostname for the request (default "github.com")
-i, --include Include HTTP response status line and headers in the output
--input file The file to use as body for the HTTP request (use "-" to read from standard input)
-q, --jq string Query to select values from the response using jq syntax
-X, --method string The HTTP method for the request (default "GET")
--paginate Make additional HTTP requests to fetch all pages of results
-p, --preview strings Opt into GitHub API previews (names should omit '-preview')
-f, --raw-field key=value Add a string parameter in key=value format
--silent Do not print the response body
--slurp Use with "--paginate" to return an array of all pages of either JSON arrays or objects
-t, --template string Format JSON output using a Go template; see "gh help formatting"
--verbose Include full HTTP request and response in the output

## Examples

The examples below assume that all the commands are executed from a folder
which contains the repository. We also assume that the PR number is 71.

### Example: List reviews for a pull request

```bash
gh api /repos/{owner}/{repo}/pulls/71/reviews
```

### Example: List review comments on a pull request

```bash
gh api /repos/{owner}/{repo}/pulls/71/comments
```

### Example: Create a review for a review comment

- Note that the first comment covers a range of lines, so it has both
  `start_line` and `line` properties.
- The second comment is a single line comment, so it only has the `line` property.
- The response contains an `id` property we need to keep in order to
  submit the review later.

```bash
gh api -X POST /repos/{owner}/{repo}/pulls/71/reviews \
   --input - <<< '
{
  "comments": [
    {
      "path": ".github/workflows/build.yml",
      "body": "I have a question about this part of the code.",
      "start_line": 49,
      "line": 56
    },
    {
      "path": ".github/workflows/build.yml",
      "body": "I have a question about this part of the code also.",
      "line": 20
    }
  ]
}'

# ID returned in the response: 4058659785
```

## Example: Submit a review for a pull request

Here we use the ID from the previous example to submit the review.
We will approve this PRs, but you can also set the event to `REQUEST_CHANGES` or `COMMENT` depending on the outcome of your code review.

```bash
gh api -X POST /repos/{owner}/{repo}/pulls/71/reviews/4058659785/events \
-f body="LGTM" -f event=APPROVE
```

## Example: Create a reply for a review comment

We assume that the comment ID we want to reply
to is `3035786540` and the PR number is `71`

```bash
gh api -X POST /repos/{owner}/{repo}/pulls/71/comments/3035786540/replies \
-f body="nevermind, I figured it out"
```
