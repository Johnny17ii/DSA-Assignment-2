//import ballerina/http;
import ballerina/graphql;
import ballerinax/mongodb;
import ballerina/log;

mongodb:ConnectionConfig mongoConfig = {
    connection: {
        host: "localhost",
        port: 27017,
        auth: {
            username: "",
            password: ""
        },
        options: {
            sslEnabled: false,
            serverSelectionTimeout: 5000
        }
    },
    databaseName: "PerformanceManagement"
};

mongodb:Client mongodb = check new (mongoConfig);

type User record {
    string username;
    string password;
    string jobTitle;
    string position;
    string role;
};

type Objective record {
    int id;
    string name;
    float weight;
};

type KPI record {
    int id;
    int userId;
    int objectiveId;
    float value; // Value of the KPI
    string unit; // Unit of measurement
};

@graphql:ServiceConfig {
    graphiql: {
        enabled: true
    }
}
service /performanceManagement on new graphql:Listener(9090) {


    

    remote function createUser(User newUser) returns string|error {
        _= check mongodb->insert(<map<json>>newUser.toJson(), "userCollection");
        return "User created succesfully";
        
    }
    

    remote function createObjective(Objective newObjective) returns string|error {
        _= check mongodb->insert(<map<json>>newObjective.toJson(), "objectiveCollection");
        return "Objective created successfully";
    }

    remote function createKPI(KPI newKPI) returns string|error {
        _= check mongodb->insert(<map<json>>newKPI.toJson(), "kpiCollection");
        return "KPI created successfully";
    }

    resource function get getUsers() returns string|error {
        var allUsers = check mongodb->find("userCollection", "performanceManagement", {}, {}, {}, -1, -1, []);
        log:printInfo(allUsers.toString());
        return "All users: ";
    }

    resource function get getKPIs() returns string|error {
        var allKPIs = check mongodb->find("kpiCollection", "performanceManagement", {}, {}, {}, -1, -1, []);
        log:printInfo(allKPIs.toString());
        return "KPIs: ";
    }

    resource function get getObjective(int id) returns string|error {
        var allObjectives = check mongodb->find("objectiveCollection", "performanceManagement", {}, {}, {}, -1, -1, []);
        log:printInfo(allObjectives.toString());
        return "Objectives: ";
    }

    resource function get getKPIId(int id) returns string|error {
        var allObjectives = check mongodb->find("objectiveCollection", "performanceManagement", {}, {}, {}, -1, -1, []);
        log:printInfo(allObjectives.toBalString());
        return "KPI id: ";
    }
}