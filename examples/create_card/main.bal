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
import ballerinax/trello as trello;

configurable string key = ?;
configurable string token = ?;

configurable string listId = ?;
configurable string boardId = ?;

trello:ApiKeysConfig apiKeyConfig = {
    key,
    token
};

trello:Client trello = check new (apiKeyConfig, {});

public function main() returns error? {
    string cardName = "New Card";
    trello:PostCardsQueries cardQueries = {
        idList: listId,
        name: cardName
    };
    trello:Card createdCard = check trello->/cards.post({}, cardQueries);
    io:println("Card created: ", createdCard.name, " (ID: ", createdCard.id, ")");

    string updatedCardName = "Updated Card Name";
    trello:PutCardsIdQueries updateQueries = {
        name: updatedCardName
    };
    string createdCardId = check createdCard.id.ensureType();

    trello:Card updatedCard = check trello->/cards/[createdCardId].put({}, updateQueries);
    io:println("Card updated: ", updatedCard.name, " (ID: ", updatedCard.id, ")");

    check getCardById(updatedCard.id);
    trello:PostBoardsIdLabelsQueries labelQueries = {
        name: "Urgent",
        color: "red"
    };
    trello:Label|error? labelCreateResult = check trello->/boards/[boardId]/labels.post({}, labelQueries);
    if labelCreateResult is error {
        io:println("Failed to create label: ", labelCreateResult.message());
        return;
    }
    string labelId = check (<trello:Label>labelCreateResult).id.ensureType();

    trello:PostCardsIdIdlabelsQueries addLabelQueries = {
        value: labelId
    };
    check trello->/cards/[createdCardId]/idLabels.post({}, addLabelQueries);
    io:println("Label added to card successfully.");
}

function getCardById(trello:TrelloID? cardId) returns error? {
    if cardId is () {
        io:println("No card ID provided.");
        return;
    }
    trello:GetCardsIdQueries queries = {};
    trello:Card card = check trello->/cards/[cardId]({}, queries);
    io:println("Fetched card Name: ", card.name);
    io:println("Fetched card ID: ", card.id);
}
