# Ballerina Trello connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-trello/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-trello/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-trello.svg)](https://github.com/ballerina-platform/module-ballerinax-trello/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/trello.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%trello)

## Overview

[Trello](https://trello.com/) is a popular web-based project management and collaboration platform developed by Atlassian, allowing users to organize tasks, projects, and workflows using boards, lists, and cards.

The `ballerinax/trello` package provides APIs to connect and interact with [Trello's RESTful API endpoints](https://developer.atlassian.com/cloud/trello/rest/api-group-actions/), enabling developers to seamlessly manage boards, lists, cards, and other Trello resources.

## Setup guide

To use the Trello connector, you must have access to the Trello API through a Trello account and an API key and token generated from it. If you do not have a Trello account, you can sign up for one [here](https://id.atlassian.com/signup). You can generate your Trello API key and token by following the instructions at [Trello API Keys](https://developer.atlassian.com/cloud/trello/guides/rest-api/api-introduction/).

1. Visit https://trello.com/power-ups/admin and create a new powerup

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

1. [**Create and Retrieve a List and Cards in Trello**](examples/create_list/) - Create a new list in a specific Trello board and retrieve its details using the list ID.
2. [**Create, Update fetch add label to a Card in Trello**](examples/create_card/) - Create a new card in a Trello list and update the card's name and view it.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

   - [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
   - [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

   ```bash
   export packageUser=<Username>
   export packagePAT=<Personal access token>
   ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToLocalCentral=true
   ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

- For more information go to the [`trello` package](https://central.ballerina.io/ballerinax/trello/latest).
- For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
- Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
- Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
