# Running Tests

## Prerequisites

To run tests for the Trello connector, you will need:

- A Trello account.
- A Power-Up created via the Trello Developer Portal.
- Your API Key and API Token, which you can obtain from the Trello API Key page.
- The Board ID, List ID, and optionally Card IDs to test live APIs.

## Running Tests

The Trello connector supports two environments for testing:

| Test Group   | Environment                            |
| ------------ | -------------------------------------- |
| `mock_tests` | Mock server for Trello API _(default)_ |
| `live_tests` | Actual Trello API                      |

Use the `isLiveServer` configuration to switch between environments.

Please ensure that the `boardId`, `listId`, and `cardId` values correspond to actual resources in your Trello account and boards when running tests against the live API.

## Running Tests in the Mock Server

### 🔹 Using `Config.toml` in the `tests/` Directory

Create a file named `Config.toml` in the `tests/` folder with the following content:

```toml
[ballerinax.trello]
key = "api-key"
token = "api-token"
```

Set `isLiveServer` to false in `tests.bal` to set mock test environment

Then, run the following command to run the tests:

```
   ./gradlew clean test

```

## Running Tests Against Trello Live API

**Using a Config.toml File**

Create a Config.toml file in the tests directory and add your authentication credentials as follows

```
token = "<your-trellor-access-token>"
key = "<your-trello-key>"
```

Set `isLiveServer` to true in `tests.bal` to set live test environment

Note that you have to use your real trello Board and List IDs when testing in the live environment.

Then, run the following command to run the tests:

```
./gradlew clean test
```
