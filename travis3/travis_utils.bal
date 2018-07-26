function createResponse(string authToken) returns http:Request {
    http:Request request = new;
    request.setHeader("Content-Type", "application/json");
    request.setHeader("Accept", "application/json");
    request.setHeader("Travis-API-Version", "3");
    request.setHeader("Authorization", "token " + authToken);
    return request;
}

function getJsonPayload(http:Response|error response) returns json|error {
    match response {
        http:Response httpResponse => {
            var jsonPayload = httpResponse.getJsonPayload();
            match jsonPayload {
                json payload => return payload;
                error err => return err;
            }
        }
        error err => return err;
    }
}
