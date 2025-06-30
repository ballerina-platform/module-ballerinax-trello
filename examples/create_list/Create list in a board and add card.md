# Create and Retrieve a List and Cards in Trello

This example demonstrates how to use the Trello API with Ballerina to:

- Create a new list on a specified Trello board.
- Fetch the created list by its ID.
- Add a card to that list
- Retrieve all cards from that list.

This use case is helpful for managing task groups programmatically, such as setting up project boards or automating workflow stages.

---

## Prerequisites

### 1. Trello Developer Access

Refer to the [Setup guide](../../README.md) to obtain necessary credentials (client Id, client secret, tokens).

### 2. Board ID

Before running the example, make sure you have:

- A valid **Board ID** where the new list will be created

You can retrieve the board ID from the URL of the board in Trello or by calling Trello's `GET /members/me/boards` endpoint.

---

## Configuration

Create a file named `Config.toml` in the root directory of this example with the following content:

```toml
apiKey = "<Your Trello API Key>"
apiToken = "<Your Trello API Token>"
```

## Run the example

Execute the following command to run the example:

Note that the list Id has to be a valid one

```bash
bal run -- <listId>
```
