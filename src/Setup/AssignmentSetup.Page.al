page 50102 "Assignment Setup"
{
    PageType = Card;
    SourceTable = "Assignment Setup";
    Caption = 'Assignment Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {

                field("Assignment Nos"; Rec."Assignment Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Assignment Nos field.', Comment = '%';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;

}
