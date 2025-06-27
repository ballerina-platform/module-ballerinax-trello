import ballerina/io;
import ballerinax/trello;

configurable string key = ?;
configurable string token = ?;

string listId = "68539f5c1899d49ed12e804e";
string boardId = "68539f4be9c2176c10e6a77d";

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

    trello:Card|error createdCardResult = trello->/cards.post({}, cardQueries);
    if createdCardResult is error {
        io:println("Failed to create card: ", createdCardResult.message());
        return;
    }

    trello:Card createdCard = <trello:Card>createdCardResult;
    io:println("Card created: ", createdCard.name, " (ID: ", createdCard.id, ")");

    string updatedCardName = "Updated Card Name";
    trello:PutCardsIdQueries updateQueries = {
        name: updatedCardName
    };
    string createdCardId = check createdCard.id.ensureType();

    trello:Card|error updatedCardResult = trello->/cards/[createdCardId].put({}, updateQueries);
    if updatedCardResult is error {
        io:println("Failed to update card: ", updatedCardResult.message());
        return;
    }

    trello:Card updatedCard = <trello:Card>updatedCardResult;
    io:println("Card updated: ", updatedCard.name, " (ID: ", updatedCard.id, ")");

    check getCardById(updatedCard.id);
    trello:PostBoardsIdLabelsQueries labelQueries = {
        name: "Urgent",
        color: "red"
    };
    trello:Label|error? labelCreateResult = trello->/boards/[boardId]/labels.post({}, labelQueries);
    if labelCreateResult is error {
        io:println("Failed to create label: ", labelCreateResult.message());
        return;
    }
    string labelId = check (<trello:Label>labelCreateResult).id.ensureType();

    trello:PostCardsIdIdlabelsQueries addLabelQueries = {
        value: labelId
    };
    error? addLabelResult = trello->/cards/[createdCardId]/idLabels.post({}, addLabelQueries);
    if addLabelResult is error {
        io:println("Failed to add label to card: ", addLabelResult.message());
        return;
    }
    io:println("Label added to card successfully.");
}

function getCardById(trello:TrelloID? cardId) returns error? {
    if cardId is () {
        io:println("No card ID provided.");
        return;
    }
    trello:GetCardsIdQueries queries = {};
    trello:Card|error result = trello->/cards/[cardId]({}, queries);
    if result is error {
        io:println("Failed to get card: ", result.message());
        return result;
    }
    trello:Card cardDetails = <trello:Card>result;
    io:println("Fetched card Name: ", cardDetails.name);
    io:println("Fetched card ID: ", cardDetails.id);
    return;
}
