## Overview

[Trello](https://trello.com/) is a popular web-based project management and collaboration platform developed by Atlassian, allowing users to organize tasks, projects, and workflows using boards, lists, and cards.

The `ballerinax/trello` package provides APIs to connect and interact with [Trello's RESTful API endpoints](https://developer.atlassian.com/cloud/trello/rest/api-group-actions/), enabling developers to seamlessly manage boards, lists, cards, and other Trello resources.

## Setup guide

To use the Trello connector, you must have access to the Trello API through a Trello account and an API key and token generated from it. If you do not have a Trello account, you can sign up for one [here](https://id.atlassian.com/signup). You can generate your Trello API key and token by following the instructions at [Trello API Keys](https://developer.atlassian.com/cloud/trello/guides/rest-api/api-introduction/).

1. Visit [Trello powerups admin](https://trello.com/power-ups/admin) page and create a new powerup

   ![trello powerup](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-trello/refs/heads/main/docs/setup/resources/trello-powerups.png)

2. Enter the required details:

   - Name of your Power-Up
   - Iframe Connector URL (can be a placeholder URL during development)
     Click “Create” to create your Power-Up.

   ![trello powerup form](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-trello/refs/heads/main/docs/setup/resources/trello-form.png)

3. Navigate to 'API Key' and click on 'Generate'

   ![generate trello apikey](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-trello/refs/heads/main/docs/setup/resources/trello-generateKey.png)

   Copy and securely store your API Key.

4. Next to the API Key description, there's a link to the token.
   Click the link, authorize the Power-Up, and you’ll be redirected to a page displaying your OAuth token.

   ![get trello Key](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-trello/refs/heads/main/docs/setup/resources/trello-key.png)

   ![allow token](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-trello/refs/heads/main/docs/setup/resources/trello-permission.png)

   Copy and securely store the Token.

   ![trello token](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-trello/refs/heads/main/docs/setup/resources/trello-token.png)

## Quickstart

To use the Trello connector in your Ballerina application, update the .bal file as follows:

#### Step 1: Import the module

Import the Trello module.

```bash
import ballerinax/trello;
```

#### Step 2: Instantiate a new connector

Create a `Config.toml` file and configure the obtained credentials as follows:

```bash
key = "your_api_key"
token = "your_api_token"
```

#### Step 3: Invoke the connector operation

Now, utilize the available connector operations.
Create a card

```bash
public function main() returns error? {
    trello:PostCardsQueries cardPayload = {
        idList: listId,
        name: "This is a sample card"
    };
    trello:Card createdCard = check trello->/cards.post({}, cardPayload);
    io:println("Card created: ", createdCard.name, " (ID: ", createdCard.id, ")");
}
```

#### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `Trello` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/module-ballerinax-trello/tree/main/examples/), covering the following use cases:

1. [**Create and retrieve a list and cards in Trello**](https://github.com/ballerina-platform/module-ballerinax-trello/tree/main/examples/create_list) - Create a new list in a specific Trello board and retrieve its details using the list ID.
2. [**Create, update fetch and add a label to a card in Trello**](https://github.com/ballerina-platform/module-ballerinax-trello/tree/main/examples/create_card) - Create a new card in a Trello list and update the card's name add a label to it and view it.
