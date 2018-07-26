import ballerina/http;
import ballerina/io;
import ballerina/log;

public type TravisConnector object {

    public string authToken;
    public http:Client client = new;

    public function getEnvironmentVariables(string organization, string name) returns json|error {
        endpoint http:Client httpClient = client;

        http:Request request = createResponse(authToken);
        string requestPath = "/repo/" + organization + "%2F" + name + "/env_vars";

        var response = httpClient->get(requestPath, message = request);
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

    public function createEnvironmentVariable(string organization, string name, json<EnvVar> envVar)
                        returns json|error {
        endpoint http:Client httpClient = client;

        http:Request request = createResponse(authToken);
        request.setJsonPayload(envVar);

        string requestPath = "/repo/" + organization + "%2F" + name + "/env_vars";

        var response = httpClient->post(requestPath, request);
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

    public function deleteEnvironmentVariable(string organization, string name, string id)
                        returns json|error {
        endpoint http:Client httpClient = client;
        http:Request request = createResponse(authToken);

        string requestPath = "/repo/" + organization + "%2F" + name + "/env_var/" + id;

        var response = httpClient->delete(requestPath, request);
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
};
