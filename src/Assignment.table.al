table 50100 Assignment
{
    DataClassification = CustomerContent;
    Caption = 'Assignment';
    DrillDownPageId = "Assignment List";
    LookupPageId = "Assignment List";
    DataCaptionFields = "No.", Title;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'No.';

            trigger OnValidate()
            var
                AssignmentSetup: Record "Assignment Setup";
                NoSeries: Codeunit "No. Series";
            begin
                if Rec."No." <> xRec."No." then begin
                    AssignmentSetup.InsertIfNotExists();
                    NoSeries.TestManual(AssignmentSetup."Assignment Nos");
                    Rec."No. Series" := '';
                end;
            end;
        }

        //2 ”User ID” - Integer
        field(2; "User Id"; Integer)
        {
            DataClassification = EndUserPseudonymousIdentifiers;
            Caption = 'User Id';
        }

        //3 Title – Text[100]
        field(3; Title; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Title';
        }

        //4 Description – Text[250] 
        field(4; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';

        }

        field(5; Status; Enum "Assignment Status")
        {
            DataClassification = SystemMetadata;
            Caption = 'Status';
        }

        field(107; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }

        key(Key2; "User Id")
        {
        }

    }

    trigger OnInsert()
    var
        AssignmentSetup: Record "Assignment Setup";
        NoSeries: Codeunit "No. Series";
    begin
        if "No." = '' then begin
            AssignmentSetup.InsertIfNotExists();
            Rec."No." := NoSeries.GetNextNo(AssignmentSetup."Assignment Nos");
            Rec."No. Series" := AssignmentSetup."Assignment Nos";
        end;
    end;

    procedure AssistEdit() Result: Boolean
    var
        AssignmentSetup: Record "Assignment Setup";
        NoSeries: Codeunit "No. Series";
    begin
        AssignmentSetup.InsertIfNotExists();
        AssignmentSetup.TestField("Assignment Nos");
        if NoSeries.LookupRelatedNoSeries(AssignmentSetup."Assignment Nos", xRec."No. Series", "No. Series") then begin
            "No." := NoSeries.GetNextNo("No. Series");
            exit(true);
        end;
    end;
}