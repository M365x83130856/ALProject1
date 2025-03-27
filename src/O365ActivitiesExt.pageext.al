pageextension 50100 "O365 Activities Ext" extends "O365 Activities"
{
    layout
    {
        addafter("Incoming Documents")
        {
            cuegroup("Assignments Cue")
            {
                Caption = 'Assignments';
                field(Assignments; Rec.Assignments)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies current assignments in the company.';
                }
            }
        }
    }
}