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

import ballerina/io;
import ballerinax/trello;

configurable string key = ?;
configurable string token = ?;

trello:ApiKeysConfig apiKeyConfig = {
    key,
    token
};

trello:Client trello = check new (apiKeyConfig, {});

function createNewList(string boardId) returns string|error {
    trello:PostListsQueries queries = {
        "idBoard": boardId,
        "name": "My New Trello List"
    };
    trello:TrelloList createdList = check trello->/lists.post({}, queries);
    io:println("Created list ID: ", createdList.id);
    io:println("List Name: ", createdList.name);
    return <string>createdList.id;
}

function getListById(string listId) returns error? {
    trello:GetListsIdQueries queries = {};
    trello:TrelloList result = check trello->/lists/[listId]({}, queries);

    trello:TrelloList listDetails = <trello:TrelloList>result;
    io:println("Fetched List Name: ", listDetails.name);
    io:println("Fetched List ID: ", listDetails.id);
    return;
}

public function main(string... args) returns error? {
    if args.length() < 1 {
        io:println("Usage: bal run [package_path] -- <listId>");
        return;
    }
    string listId = args[0];

    string|error listIdResult = createNewList(listId);
    if listIdResult is error {
        io:println("Failed to create list: ", listIdResult.message());
        return listIdResult;
    }
    string createdListId = <string>listIdResult;

    trello:GetListsIdQueries queries = {};
    trello:TrelloList listResult = check trello->/lists/[createdListId]({}, queries);

    trello:TrelloList listDetails = <trello:TrelloList>listResult;
    io:println("Created list ID: ", listDetails.id);
    io:println("Created List Name: ", listDetails.name);

    string cardName = "New Card";
    trello:PostCardsQueries cardQueries = {
        idList: createdListId,
        name: cardName
    };

    trello:Card createdCardResult = check trello->/cards.post({}, cardQueries);

    trello:Card createdCard = <trello:Card>createdCardResult;
    io:println("Card created: ", createdCard.name, " (ID: ", createdCard.id, ")");

    io:println("Details of Cards in list:");
    check getCardsInList(createdListId);
}

function getCardsInList(string listId) returns error? {
    trello:Card[] cards = check trello->/lists/[listId]/cards();
    io:println("Cards in list (", listId, "):");
    foreach var card in cards {
        io:println(" - ", card.name, " (ID: ", card.id, ")");
    }
}
