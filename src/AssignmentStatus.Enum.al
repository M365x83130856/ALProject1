enum 50100 "Assignment Status"
{
    Extensible = false;

    value(0; Incomplete)
    {
        Caption = 'Incomplete';
    }
    value(1; "In Progress")
    {
        Caption = 'In Progress';
    }
    value(2; Completed)
    {
        Caption = 'Completed';
    }
    value(3; Removed)
    {
        Caption = 'Removed';
    }
}