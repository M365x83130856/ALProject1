report 50100 "Assignment Print"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = WordLayout;

    dataset
    {
        dataitem(Assignment; Assignment)
        {
            //DataItemTableView = where(Status = const(Incomplete));
            RequestFilterFields = "User Id", Status;

            column(No_; "No.")
            {
                IncludeCaption = true;
            }
            column(Title_Assignment; Title)
            {
                IncludeCaption = true;
            }
            column(Status_Assignment; Status)
            {
                IncludeCaption = true;
            }
            column(UserId_Assignment; "User Id")
            {
                IncludeCaption = true;
            }
        }
    }

    rendering
    {
        layout(WordLayout)
        {
            Type = Word;
            LayoutFile = 'AssignmentPrint.docx';
        }
    }


    labels
    {
        ReportCaption = 'Assignment Printout';
    }

    // Ctrl + Shift + B to build and generate the AssignmentPrint.docx file
}