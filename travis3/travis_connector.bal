import ballerina/http;
import ballerina/io;
import ballerina/log;

public type TravisConnector object {

    public string authToken;
    public http:Client client = new;

    public function getEnvironmentVariables(string organization, string name) returns json|error {
        endpoint http:Client httpClient = client;

        string requestPath = "/repo/" + organization + "%2F" + name + "/env_vars";

        http:Request request = createResponse(authToken);
        var response = httpClient->get(requestPath, message = request);
        return getJsonPayload(response);
    }

    public function createEnvironmentVariable(string organization, string name, json<EnvVar> envVar)
                        returns json|error {
        endpoint http:Client httpClient = client;

        string requestPath = "/repo/" + organization + "%2F" + name + "/env_vars";

        http:Request request = createResponse(authToken);
        request.setJsonPayload(envVar);
        var response = httpClient->post(requestPath, request);
        return getJsonPayload(response);
    }

    public function deleteEnvironmentVariable(string organization, string name, string id) returns json|error {
        endpoint http:Client httpClient = client;

        string requestPath = "/repo/" + organization + "%2F" + name + "/env_var/" + id;

        http:Request request = createResponse(authToken);
        var response = httpClient->delete(requestPath, request);
        return getJsonPayload(response);
    }

    public function triggerBuild(string organization, string name) returns json|error {
        endpoint http:Client httpClient = client;

        string requestPath = "/repo/" + organization + "%2F" + name + "/requests";
        json payload = {
            "request": {
                "branch": "master"
            }
        };
        http:Request request = createResponse(authToken);
        request.setJsonPayload(payload);
        var response = httpClient->post(requestPath, request);
        return getJsonPayload(response);
    }
};
