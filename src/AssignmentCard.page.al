page 50101 "Assignment Card"
{
    PageType = Card; //Rasmus card page comment
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Assignment;

    AboutTitle = 'Assignment';
    AboutText = 'Creating an assignment for a user, to do later';

    layout
    {
        area(Content)
        {
            group(General)
            {
                AboutTitle = 'General Info';
                AboutText = 'You will setup the basic information on the assignment, defining who is responsible and what the person is supposed to be doing.';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit() then
                            CurrPage.Update();
                    end;
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'This is a brief description of the assignment.';
                    ShowMandatory = true;

                    AboutTitle = 'Assignment Title';
                    AboutText = 'This field is used to describe the assignment through the solution, when we are referring to the assignment.';

                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }

                field("User Id"; Rec."User Id")
                {
                    ToolTip = 'Specifies the value of the User Id field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        MyNotification: Notification;
    begin
        if Rec.Description = '' then begin
            MyNotification.Message('The description is missing, please add one');
            MyNotification.AddAction('Add Title as Description', codeunit::"Assignment Notitication", 'AddDescriptionFromTitle');
            MyNotification.SetData('No.', Rec."No.");
            MyNotification.Send();
        end;
    end;

    trigger OnOpenPage()
    begin
        if Rec."No." = '' then
            VerifyAssignmentNosOnSetup();
    end;

    local procedure VerifyAssignmentNosOnSetup()
    var
        AssignmentSetup: Record "Assignment Setup";
        AssignErrorInfo: ErrorInfo;
    begin
        AssignmentSetup.InsertIfNotExists();
        if AssignmentSetup."Assignment Nos" = '' then begin
            AssignErrorInfo.DataClassification(DataClassification::SystemMetadata);
            AssignErrorInfo.ErrorType(ErrorType::Client);
            AssignErrorInfo.Verbosity(Verbosity::Critical);
            AssignErrorInfo.Title('You are missing the no series on the assignment setup');
            AssignErrorInfo.Message('Go to the Assignment Setup and add the no series');
            AssignErrorInfo.AddAction('Assignment Setup', Codeunit::"Assignment Notitication", 'AssignmentNosMissing');
            Error(AssignErrorInfo);
        end;
    end;
}