import ballerina/io;
import ballerinax/trello as trello;

configurable string key = ?;
configurable string token = ?;

string listId = "68539f4be9c2176c10e6a77d";

trello:ApiKeysConfig apiKeyConfig = {
    key,
    token
};

trello:Client trello = check new (apiKeyConfig, {});

function createNewList() returns string|error {

    trello:PostListsQueries queries = {
        "idBoard": listId,
        "name": "My New Trello List"
    };

    trello:TrelloList|error result = trello->/lists.post({}, queries);

    if result is error {
        io:println("Failed to create list: ", result.message());
        return result;
    }

    trello:TrelloList created = <trello:TrelloList>result;
    io:println("Created list ID: ", created.id);
    io:println("List Name: ", created.name);
    return <string>created.id;
}

function getListById(string listId) returns error? {

    trello:GetListsIdQueries queries = {};

    trello:TrelloList|error result = trello->/lists/[listId]({}, queries);
    if result is error {
        io:println("Failed to get list: ", result.message());
        return result;
    }
    trello:TrelloList listDetails = <trello:TrelloList>result;
    io:println("Fetched List Name: ", listDetails.name);
    io:println("Fetched List ID: ", listDetails.id);
    return;
}

public function main() returns error? {
    // Create a new list and get its ID
    string|error listIdResult = createNewList();
    if listIdResult is error {
        io:println("Failed to create list: ", listIdResult.message());
        return listIdResult;
    }
    string listId = <string>listIdResult;

    // Fetch and print the created list details
    trello:GetListsIdQueries queries = {};
    trello:TrelloList|error listResult = trello->/lists/[listId]({}, queries);
    if listResult is error {
        io:println("Failed to fetch list details: ", listResult.message());
        return listResult;
    }
    trello:TrelloList listDetails = <trello:TrelloList>listResult;
    io:println("Created list ID: ", listDetails.id);
    io:println("Created List Name: ", listDetails.name);

    string cardName = "New Card";
    trello:PostCardsQueries cardQueries = {
        idList: listId,
        name: cardName
    };

    trello:Card|error createdCardResult = trello->/cards.post({}, cardQueries);
    if createdCardResult is error {
        io:println("Failed to create card: ", createdCardResult.message());
        return;
    }

    trello:Card createdCard = <trello:Card>createdCardResult;
    io:println("Card created: ", createdCard.name, " (ID: ", createdCard.id, ")");

    // Fetch and print details of cards in the list
    io:println("Details of Cards in list:");
    check getCardsInList(listId);
}

function getCardsInList(string listId) returns error? {
    trello:Card[]|error cardsResult = trello->/lists/[listId]/cards();
    if cardsResult is error {
        io:println("Failed to get cards in list: ", cardsResult.message());
        return cardsResult;
    }
    trello:Card[] cards = <trello:Card[]>cardsResult;
    io:println("Cards in list (", listId, "):");
    foreach var card in cards {
        io:println(" - ", card.name, " (ID: ", card.id, ")");
    }
    return;
}
