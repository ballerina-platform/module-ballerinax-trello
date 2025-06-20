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

import ballerina/http;
import ballerina/log;

service / on new http:Listener(9090) {


    # Retrieves a mock Trello board identified by its id.
    #
    # + id - The board ID (24-hex string in real calls).
    # + return - An error or a mock board record.

    resource function get boards/[string id](http:Caller caller, http:Request req) returns error? {
        log:printInfo("Received GET /boards/" + id);

        Board response = {
            id: "6731e178ded80bd4c6da4665", 
            name: "Mock Board",
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

        check caller->respond(response);
        return;
    }

     # Creates a new mock Trello card.
    #
    # + caller - The caller of this resource function
    # + req - The inbound HTTP request
    # + return - An error if responding fails, otherwise nil
   resource function post cards(http:Caller caller, http:Request req) returns error? {
        log:printInfo("Mock: Received POST /cards");

        Card newCard = {
            id: "63c2d4d8f66e6c21e5e37ab7",
            name: "My New Trello Card",
            desc: "A mock card from the POST /cards endpoint",
            closed: false,
            due: (),
            url: "http://localhost:9090/cards/mockCardId123"
        };

        check caller->respond(newCard);
        return;
    }

     # Retrieves a mock Trello list by ID.
    #
    # + id - The list ID
    # + caller - The caller of this resource function
    # + req - The inbound HTTP request
    # + return - An error if responding fails, otherwise nil

    resource function get lists/[string id](http:Caller caller, http:Request req) returns error? {
        log:printInfo("Received GET /lists/");

        TrelloList mockList = {
            id: id,
            name: "Mock Trello List",
            idBoard: "mockBoardId",
            closed: false
        };

        check caller->respond(mockList);
        return;
    }


    # Creates a new mock Trello list.
    #
    # + caller - The caller of this resource function
    # + req - The inbound HTTP request
    # + return - An error if responding fails, otherwise nil
    resource function post lists(http:Caller caller, http:Request req) returns error? {
        log:printInfo("Mock: Received POST /boards/" + testListID + "/lists");

        TrelloList newList = {
            name: "Mock List for Board " + testListID,
            idBoard: "6731e178ded80bd4c6da4665",
            closed: false,
            "url": "http://localhost:9090/boards/" + testListID + "/lists/newListId123"
        };

        check caller->respond(newList);
        return;
    }

     # Retrieves a mock Trello card by ID.
    #
    # + id - The ID of the card
    # + caller - The caller of this resource function
    # + req - The inbound HTTP request
    # + return - An error if responding fails, otherwise nil
    resource function get cards/[string id](http:Caller caller, http:Request req) returns error? {
        log:printInfo("Received GET /cards/" + id);

        Card mockCard = {
            id: id,
            name: "Mock Trello Card",
            desc: "A mock card from the GET endpoint",
            closed: false,
            idList: "68539f5c1899d49ed12e804e",
            idBoard: "6731e178ded80bd4c6da4665",
            due: ()
        };

        check caller->respond(mockCard);
        return;
    }

    # Updates a mock Trello card by ID.
    #
    # + cardId - The ID of the card to update
    # + caller - The caller of this resource function
    # + req - The inbound HTTP request
    # + return - An error if responding fails, otherwise nil
    resource function put cards/[string cardId](http:Caller caller, http:Request req) returns error? {
    log:printInfo("Mock: Received PUT /cards/" + cardId);

    Card updatedCard = {
        id: cardId,
        name: "Updated Card Name",
        desc: "Mock updated description",
        closed: false,
        idList: "68539f5c1899d49ed12e804e",
        idBoard: "63c2d4d8f66e6c21e5e37ab5",
        due: (),
        url: "http://localhost:9090/cards/" + cardId
    };

    check caller->respond(updatedCard);
    return;
}
     # Deletes a mock Trello card by ID.
    #
    # + id - The ID of the card to delete
    # + caller - The caller of this resource function
    # + req - The inbound HTTP request
    # + return - An error if responding fails, otherwise nil
    resource function delete cards/[string id](http:Caller caller, http:Request req) returns error? {
        log:printInfo("Received DELETE /cards/" + id);

        json deletionResult = { message: "Card " + id + " deleted successfully" };
        check caller->respond(deletionResult);
        return;
    }
}