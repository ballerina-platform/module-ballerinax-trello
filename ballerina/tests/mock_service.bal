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

import ballerina/http;

service / on new http:Listener(9090) {
    # Retrieves a mock Trello board identified by its id.
    #
    # + id - The board ID (24-hex string in real calls).
    # + return - An error or a mock board record.
    resource function get boards/[string id]() returns Board|error {
        return {
            id: "68539f4be9c2176c10e6a77d",
            name: "Testing",
            desc: "Mock description",
            descData: (),
            closed: false,
            idOrganization: "670e109943e32996b82be42f",
            pinned: false,
            url: "https://trello.com/b/" + id,
            shortUrl: "https://trello.com/b/" + id,
            prefs: {},
            labelNames: {}
        };
    }

    # Creates a new mock Trello card.
    #
    # + caller - The caller of this resource function
    # + req - The inbound HTTP request
    # + return - An error if responding fails, otherwise nil
    resource function post cards() returns Card|error {
        return {
            id: "63c2d4d8f66e6c21e5e37ab7",
            name: "My New Trello Card",
            desc: "A mock card from the POST /cards endpoint",
            closed: false,
            due: (),
            url: "http://localhost:9090/cards/mockCardId123"
        };
    }

    # Retrieves a mock Trello list by ID.
    #
    # + id - The list ID
    # + caller - The caller of this resource function
    # + req - The inbound HTTP request
    # + return - An error if responding fails, otherwise nil
    resource function get lists/[string id]() returns TrelloList|error? {
        return {
            id: id,
            name: "My New Trello List",
            idBoard: "68539f4be9c2176c10e6a77d",
            closed: false
        };
    }

    # Creates a new mock Trello list.
    #
    # + caller - The caller of this resource function
    # + req - The inbound HTTP request
    # + return - An error if responding fails, otherwise nil
    resource function post lists() returns TrelloList|error {
        return {
            name: "My New Trello List",
            idBoard: "68539f4be9c2176c10e6a77d",
            closed: false,
            "url": "http://localhost:9090/boards/68539f4be9c2176c10e6a77d/lists/newListId123"
        };
    }

    # Retrieves a mock Trello card by ID.
    #
    # + id - The ID of the card
    # + caller - The caller of this resource function
    # + req - The inbound HTTP request
    # + return - An error if responding fails, otherwise nil
    resource function get cards/[string id]() returns Card|error {
        return {
            id: id,
            name: "Mock Trello Card",
            desc: "A mock card from the GET endpoint",
            closed: false,
            idList: "68539f5c1899d49ed12e804e",
            idBoard: "6731e178ded80bd4c6da4665",
            due: ()
        };
    }

    # Updates a mock Trello card by ID.
    #
    # + cardId - The ID of the card to update
    # + caller - The caller of this resource function
    # + req - The inbound HTTP request
    # + return - An error if responding fails, otherwise nil
    resource function put cards/[string cardId]() returns Card|error {
        return {
            id: cardId,
            name: "Updated Card Name",
            desc: "Mock updated description",
            closed: false,
            idList: "68539f5c1899d49ed12e804e",
            idBoard: "63c2d4d8f66e6c21e5e37ab5",
            due: (),
            url: "http://localhost:9090/cards/" + cardId
        };
    }

    # Deletes a mock Trello card by ID.
    #
    # + id - The ID of the card to delete
    # + caller - The caller of this resource function
    # + req - The inbound HTTP request
    # + return - An error if responding fails, otherwise nil
    resource function delete cards/[string id]() returns Card|error {
        return {"message": "Card " + id + " deleted successfully"};

    }
}

