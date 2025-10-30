table 70190 "Customer Demo Structured"
{
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(1; id; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Customer Name"; Text[80])
        {
            DataClassification = ToBeClassified;

        }
        field(3; Address; Text[80])
        {
            DataClassification = ToBeClassified;

        }
        field(4; City; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Post Code"; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(6; Country; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(7; "Phone Number"; Text[30])
        {
            DataClassification = ToBeClassified;

        }
        field(8; Select; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Select';
        }



    }

    keys
    {
        key(PK; id)
        {
            Clustered = true;
        }
    }


}