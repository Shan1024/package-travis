import ballerina/test;
import ballerina/io;
import ballerina/config;

endpoint Client travisConnector {
    authToken: config:getAsString("travis.token")
};

@test:Config
function testAccountDetails() {
    json response = check travisConnector->getEnvironmentVariables("ballerina-guides", "ballerina-demo");
    //io:println(response);
    //io:println(response.env_vars);

    foreach j in response.env_vars {
        io:println(j.name);
        io:println(j.id);

        string id = check <string>j.id;
        io:println("id: " + id);
        var res = travisConnector->deleteEnvironmentVariable("ballerina-guides", "ballerina-demo", untaint id);
        io:println(res);
    }

    json<EnvVar> envVar = { ^"env_var.name": "abc", ^"env_var.value": "def", ^"env_var.public": true };
    response = check travisConnector->createEnvironmentVariable("ballerina-guides", "ballerina-demo", envVar);
    io:println(response);

    response = check travisConnector->getEnvironmentVariables("ballerina-guides", "ballerina-demo");
    io:println(response);
}
