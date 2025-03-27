page 50100 "Assignment List"
{
    // Rasmus added this comment, and increased the comment
    Caption = 'Assignment List';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Assignment;
    CardPageID = "Assignment Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.', Comment = '%';
                }
                field("User Id"; Rec."User Id")
                {
                    ToolTip = 'Specifies the value of the User Id field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(InsertMultipleAssignments)
            {
                ApplicationArea = All;
                Caption = 'Insert Assignments';
                Image = JobLines;

                trigger OnAction()
                var
                    AssignmentMgt: Codeunit "Assignment Mgt.";
                begin
                    AssignmentMgt.Run();
                end;
            }

            action(DeleteAllAssignments)
            {
                ApplicationArea = All;
                Caption = 'Delete All Assignments';
                Image = RemoveLine;

                trigger OnAction()
                begin
                    Rec.DeleteAll();
                end;
            }

            action(InsertMultipleAssignmentsFromAPI)
            {
                ApplicationArea = All;
                Caption = 'Insert Assignments from API';
                Image = JobLines;

                trigger OnAction()
                var
                    AssignmentMgt: Codeunit "Assignment Mgt.";
                begin
                    AssignmentMgt.GetAssignmentsFromAPI();
                end;
            }

            action(SetupWizard)
            {
                Caption = 'Setup Wizard';
                ApplicationArea = All;
                Image = Setup;

                RunObject = page "Assignment Wizard";
            }
        }

        area(Reporting)
        {
            action(AssignmentPrint)
            {
                Caption = 'Assignment Print';
                ApplicationArea = All;
                Image = PrintInstallment;

                RunObject = report "Assignment Print";
            }

            action(AssignmentPort)
            {
                Caption = 'XMLPort';
                ApplicationArea = All;
                Image = XMLFile;
                RunObject = xmlport AssignmentPort;
            }
        }
    }

    views
    {
        view(Incomplete)
        {
            Caption = 'Incomplete';
            Filters = where(Status = const(Incomplete));
        }

        view(Completed)
        {
            Caption = 'Completed';
            Filters = where(Status = const(Completed));
        }
    }
}