import ballerina/graphql;
import ballerina/io;

public function main() returns error?{
    graphql:Client graphQLclient = check new("localhost:9090");

    string name = io:readln("Enter Hod|Supervisor|Employee name: ");

    mutation`{
        createUser($username:String,$password:String,$jobTitle:String,$position:String,$roleString)
        }
`;

    string document = string ``;
    var createManagementResponse = graphQLclient->execute(document, {username, password, jobtitle, position, role}, "createUser", {},{} );
    io:println(createManagementResponse);
}
