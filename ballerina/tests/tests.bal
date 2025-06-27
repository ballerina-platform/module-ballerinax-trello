// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
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

configurable boolean isLiveServer = true;
configurable string key = "1234567890abcdef1234567890abcdef";
configurable string token = "abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890";
configurable string baseUrl = "http://localhost:9090";

string testBoardID = "8SnkvBJj";
string testListID = "68539f5c1899d49ed12e804e";

ApiKeysConfig apiKeyConfig = {
    key,
    token
};

Client trello = check new (apiKeyConfig, {}, baseUrl);

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetBoardById() returns error? {
    Board result = check trello->/boards/[testBoardID];
    test:assertEquals(result.id, "68539f4be9c2176c10e6a77d", msg = "Board ID does not match");
    test:assertEquals(result.name, "Testing", msg = "Unexpected board name");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetListById() returns error? {
    TrelloList result = check trello->/lists/[testListID];
    test:assertEquals(result.id, "68539f5c1899d49ed12e804e", msg = "List ID does not match");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateNewList() returns error? {
    PostListsQueries queries = {
        "idBoard": "68539f4be9c2176c10e6a77d",
        "name": "My New Trello List"
    };
    TrelloList result = check trello->/lists.post({}, queries);
    test:assertFalse(result !is TrelloList, msg = "Failed to call lists POST endpoint");
    test:assertEquals((check result.name).toString(), "My New Trello List", msg = "Unexpected list name");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateNewCard() returns error? {
    PostCardsQueries queries = {
        "idList": "68539f5c1899d49ed12e804e",
        "name": "My New Trello Card"
    };
    Card result = check trello->/cards.post({}, queries);
    test:assertEquals(result.name, "My New Trello Card", msg = "Unexpected card name.");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetCardById() returns error? {
    string testCardId = "6853ff7a8b3a4bbba54acd3a";

    GetCardsIdQueries queries = {

    };
    Card result = check trello->/cards/[testCardId]({}, queries);
    test:assertNotEquals(result.id, (), "Card ID cannot be empty.");
    test:assertNotEquals(result.name, (), "Card name cannot be empty.");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpdateCardName() returns error? {
    string cardId = "6853ff7a8b3a4bbba54acd3a";
    PutCardsIdQueries queries = {
        "name": "Updated Card Name"
    };

    Card result = check trello->/cards/[cardId].put({}, queries);
    test:assertEquals(result.name, "Updated Card Name", "Card name was not updated correctly.");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testDeleteCard() returns error? {
    string cardId = "685b8b113de471b8cd2e85a2";

    TrelloList result = check trello->/cards/[cardId].delete({});
    test:assertNotEquals(result, (), "Failed to delete the card.");
}

