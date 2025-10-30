table 50910 "ABC Sessions"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; id; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Session Title"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Speakers 1"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Speakers 2"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Speakers 3"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Session Type"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Session Level"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(30; "Target Audience"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Day"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }

        field(100; "String Speakers"; text[500])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
        fieldgroup(DropDown; "Session Title", "Speakers 1", "Speakers 2") { }
    }



}