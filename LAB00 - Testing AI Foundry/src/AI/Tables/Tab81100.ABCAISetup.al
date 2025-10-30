table 81100 "ABC AI Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; code; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(10; EndPoint; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "API Key"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(30; Deployment; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; code)
        {
            Clustered = true;
        }
    }

}