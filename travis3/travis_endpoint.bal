import ballerina/http;

public type Client object {

    public TravisConfiguration travisConfig;
    public TravisConnector travisConnector = new;

    public function init(TravisConfiguration config) {
        config.clientConfig.url = OPEN_SOURCE_PROJECTS_TRAVIS_URL;

        travisConnector.authToken = config.authToken;
        travisConnector.client.init(config.clientConfig);
    }

    public function getCallerActions() returns TravisConnector {
        return travisConnector;
    }
};

public type TravisConfiguration record {
    string authToken;
    http:ClientEndpointConfig clientConfig;
};
