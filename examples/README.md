# Examples

The `ballerinax/trello` connector provides practical examples illustrating usage in various scenarios.

## Available Examples

1. **Create, update, and add a label to a card**  
   Demonstrates how to create a card in a specific Trello list, update its name, and add a label to it. Useful for automating task management workflows.
2. **Create and retrieve a list and cards in Trello**  
   Demonstrates how to create a new list on a specified Trello board, fetch the created list by its ID, add a card to that list, and retrieve all cards from that list. This is useful for automating task grouping and initialization of project boards, such as setting up project boards or automating workflow stages.

---

## Prerequisites

### 1. Trello Developer Access

Refer to the [Setup guide](../README.md) to obtain necessary credentials (API key and token).

### 2. Board and List

Before running the examples, make sure you have:
- A valid **Board ID**
- A **List ID** under that board where the card will be created

You can retrieve the list ID from the URL of the list in Trello or by calling Trello's `GET /boards/{id}/lists` endpoint.

---

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
