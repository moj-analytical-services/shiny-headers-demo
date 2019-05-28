# Shiny HTTP Headers Demo

## Current User
The auth proxy provides a `USER_EMAIL` header to any application running behind
it. This is a demo of how to access that header from shiny.

## Caveats

Running this with `shiny-server` doesn't work because it filters out unknown
headers unless you pay for the pro version.
