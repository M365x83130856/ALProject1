codeunit 50101 "Assignment Notitication"
{
    procedure AddDescriptionFromTitle(MyNotification: Notification)
    var
        Assignment: Record Assignment;
        AssignmentNo: Code[20];
    begin
        AssignmentNo := MyNotification.GetData('No.');

        if Assignment.Get(AssignmentNo) then begin
            Assignment.Description := Assignment.Title;
            Assignment.Modify();
        end;
    end;


    procedure AssignmentNosMissing(AssignErrorInfo: ErrorInfo)
    begin
        Page.RunModal(Page::"Assignment Setup");
    end;
}