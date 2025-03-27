codeunit 50100 "Assignment Mgt."
{
    trigger OnRun()
    begin
        InsertMultipleAssignments(myInt);
        InsertMultipleAssignments(myInt, 'Hello New Title ');

        Message('%1 assignments were created', myInt);
    end;

    var
        myInt: Integer;


    procedure InsertAssignment(SomeTitle: Text[100])
    var
        Assignment: Record Assignment;
    begin
        Assignment.Init();
        Assignment."No." := Format(Random(999999));
        Assignment.Title := SomeTitle;
        Assignment.Description := Assignment.Title;
        Assignment."User Id" := 1;
        Assignment.Insert();
    end;

    local procedure InsertMultipleAssignments(var AssignmentCnt: Integer)
    var
        InitialAssignments: Integer;
    begin
        InitialAssignments := AssignmentCnt;
        while AssignmentCnt < (InitialAssignments + 20) do begin
            InsertAssignment('Hello While Loops ' + Format(AssignmentCnt));
            AssignmentCnt += 1;
        end;
    end;

    local procedure InsertMultipleAssignments(var AssignmentCnt: Integer; NewTitle: Text[100])
    var
        InitialAssignments: Integer;
    begin
        InitialAssignments := AssignmentCnt;
        while AssignmentCnt < (InitialAssignments + 20) do begin
            InsertAssignment(NewTitle + Format(AssignmentCnt));
            AssignmentCnt += 1;
        end;
    end;

    procedure GetAssignmentsFromAPI()
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        JsonPlaceHolderAPIErr: Label 'Something went wrong when getting the data from the API, please contact your developer.';
        Content: HttpContent;
        ContentText: Text;
        JArray: JsonArray;
        JObject: JsonObject;
        JToken: JsonToken;
        Assignment: Record Assignment;
    begin
        if not Client.Get('https://jsonplaceholder.typicode.com/todos', ResponseMessage) then
            Error(JsonPlaceHolderAPIErr);

        Content := ResponseMessage.Content();
        Content.ReadAs(ContentText);

        JArray.ReadFrom(ContentText);
        foreach JToken in JArray do begin
            JObject := JToken.AsObject();

            Assignment.Init();
            JObject.SelectToken('id', JToken);
            Assignment."No." := Format(JToken.AsValue().AsInteger());

            JObject.SelectToken('title', JToken);
            Assignment.Title := JToken.AsValue().AsText();

            JObject.SelectToken('userId', JToken);
            Assignment."User Id" := JToken.AsValue().AsInteger();

            JObject.SelectToken('completed', JToken);
            if JToken.AsValue().AsBoolean() then
                Assignment.Status := Assignment.Status::Completed
            else
                Assignment.Status := Assignment.Status::Incomplete;

            Assignment.Insert();
        end;
    end;
}