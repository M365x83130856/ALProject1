xmlport 50100 AssignmentPort
{
    Direction = Export;
    Format = VariableText;
    FieldSeparator = ',';
    FieldDelimiter = '"';
    FileName = 'assignment.csv';

    schema
    {
        textelement(root)
        {
            tableelement(Assignment; Assignment)
            {
                XmlName = 'task';
                fieldattribute(No; Assignment."No.")
                {
                }
                fieldelement(Title; Assignment.Title)
                {
                }
                fieldelement(Status; Assignment.Status)
                {
                }
                fieldelement(UserId; Assignment."User Id")
                {
                }
            }
        }
    }
}