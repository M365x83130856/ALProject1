tableextension 50100 "Activities Cue Ext" extends "Activities Cue"
{
    fields
    {
        field(50100; "Assignments"; Integer)
        {
            CalcFormula = count(Assignment);
            Caption = 'Assignments';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}