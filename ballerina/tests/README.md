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

### 🔹 Option 1: Using `Config.toml` in the `tests/` Directory

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

### 🔹Option 2: Using Environment Variables

Linux/macOS

```
export key="api-key"
export token="api-token"
```

Windows

```
setx key "api-key"
setx token "api-token"
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

**Using Environment Variables**

Alternatively, you can set your authentication credentials as environment variables:

If you are using linux or mac, you can use following method:

```
   export token ="<your-trello-access-token>"
   export key ="<your-trello-key>"
```

If you are using Windows you can use following method:

```
   setx token "<your-trello-access-token>"
   setx key  "<your-trello-key>"
```

Then, run the following command to run the tests:

```
./gradlew clean test
```
