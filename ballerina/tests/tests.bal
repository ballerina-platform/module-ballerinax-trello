// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.


import ballerina/test;

configurable string API_KEY = ?;
configurable string API_TOKEN = ?;
configurable boolean IS_MOCK = false;

string testBoardID = "8SnkvBJj";
string testListID = "68539f5c1899d49ed12e804e";

string mockBaseUrl = "http://localhost:9090";
string liveBaseUrl = "https://api.trello.com/1";
string baseUrl = IS_MOCK ? mockBaseUrl : liveBaseUrl;

ApiKeysConfig apiKeyConfig = {
    key: API_KEY,
    token: API_TOKEN
};

ConnectionConfig connConfig = check {};

Client trello = check new(apiKeyConfig, connConfig, baseUrl);

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetBoardById() returns error? {
    map<string|string[]> headers = {
        "Content-Type": "application/json"
    };

    GetBoardsIdQueries queries = {}; 

    Board|error result = trello->/boards/[testBoardID](headers, queries);

    test:assertFalse(result is error, msg = "Failed to call board GET endpoint");

    if result is json {
        test:assertEquals((check result.id).toString(), "QD5bFabu", msg = "Board ID does not match");
        test:assertEquals((check result.name).toString(), "Mock Trello Board", msg = "Unexpected board name");
    }
}
@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetListById() returns error? {
    map<string|string[]> headers = {
        "Content-Type": "application/json"
    };
    GetListsIdQueries queries = {};

    TrelloList|error result = trello->/lists/[testListID](headers, queries);
    test:assertFalse(result is error, msg = "Failed to call lists GET endpoint");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateNewList() returns error? {
    map<string|string[]> headers = {
        "Content-Type": "application/json"
    };

    PostListsQueries queries = {
        "idBoard": "68539f4be9c2176c10e6a77d",
        "name": "My New Trello List"
    };

    TrelloList|error result = trello->/lists.post(headers, queries);

    test:assertFalse(result is error, msg = "Failed to call lists POST endpoint");

    if result is json {
        test:assertEquals((check result.id).toString(), "newListId", msg = "Unexpected list ID");
        test:assertEquals((check result.name).toString(), "My New Trello List", msg = "Unexpected list name");
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateNewCard() returns error? {
    map<string|string[]> headers = {
        "Content-Type": "application/json"
    };
    PostCardsQueries queries = {
        "idList": "68539f5c1899d49ed12e804e",
        "name": "My New Trello Card"
    };

    Card|error result = trello->/cards.post(headers, queries);


    test:assertFalse(result is error, msg = "Failed to create a new card.");

    if result is Card {
        test:assertEquals(result.name, "My New Trello Card", msg = "Unexpected card name.");
    }
}
@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetCardById() returns error? {
    string testCardId = "6853ff7a8b3a4bbba54acd3a"; 
    map<string|string[]> headers = {
        "Content-Type": "application/json"
    };

    GetCardsIdQueries queries = {

    };

    Card|error result = trello->/cards/[testCardId](headers, queries);
    test:assertFalse(result is error, msg = "Failed to retrieve the Card.");

    if result is Card {
        test:assertNotEquals(result.id, (), "Card ID cannot be empty.");
        test:assertNotEquals(result.name, (), "Card name cannot be empty.");
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpdateCardName() returns error? {
    string cardId = "6853ff7a8b3a4bbba54acd3a";

    map<string|string[]> headers = {
        "Content-Type": "application/json"
    };

    PutCardsIdQueries queries = {
        "name": "Updated Card Name"
    };

    Card|error result = trello->/cards/[cardId].put(headers, queries);
    test:assertFalse(result is error, msg = "Failed to update card name.");

    if result is Card {
        test:assertEquals(result.name, "Updated Card Name", "Card name was not updated correctly.");
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testDeleteCard() returns error? {
    string cardId = "6854e94eec4d3ef63daec9ad";

    map<string|string[]> headers = {
        "Content-Type": "application/json"
    };

    TrelloList|error? result = trello->/cards/[cardId].delete(headers);

    test:assertFalse(result is error, msg = "Failed to delete card with ID: " + cardId);
}