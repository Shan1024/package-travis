function createResponse(string authToken) returns http:Request {
    http:Request request = new;
    request.setHeader("Content-Type", "application/json");
    request.setHeader("Accept", "application/json");
    request.setHeader("Travis-API-Version", "3");
    request.setHeader("Authorization", "token " + authToken);
    return request;
}
