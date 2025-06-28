# Create, Update fetch add label to a Card in Trello

This example demonstrates how to use the Trello API with Ballerina to create a card in a specific Trello list, update its name, and add a label to it. This use case is useful for automating task management workflows where card creation, modification, and labeling are performed programmatically.

---

## Prerequisites

### 1. Trello Developer Access

Refer to the [Setup guide](../../README.md) to obtain necessary credentials (client Id, client secret, tokens).

### 2. Board and List

Before running the example, make sure you have:
- A valid **Board ID**
- A **List ID** under that board where the card will be created

You can retrieve the list ID from the URL of the list in Trello or by calling Trello's `GET /boards/{id}/lists` endpoint.

---
## Configuration

Create a file named `Config.toml` in the root directory of this example with the following content:

```toml
key = "<Your Trello API Key>"
token = "<Your Trello API Token>"
```

## Run the example

Execute the following command to run the example:

```bash
bal run
```
