_Author_: @SashenkaG\
_Created_: 25/07/2025 \
_Updated_: 25/07/2025 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Trello.
The OpenAPI specification is obtained from this [site](https://developer.atlassian.com/cloud/trello/rest/api-group-actions/#api-group-actions) through the [link](https://dac-static.atlassian.com/cloud/trello/swagger.v3.json?_v=1.606.0)

These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Updated the OpenAPI specification to allow nullable fields where appropriate.
2. Added explicit response bodies to the GET and POST `/lists` methods to accurately reflect the expected API responses.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. 

The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/openapi.json --mode client -o ballerina
```

