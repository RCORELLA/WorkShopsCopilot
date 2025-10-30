page 70191 "Copilot Demo Cust Sub Page"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;

    SourceTable = "Customer Demo Structured";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }

                field(id; Rec.id)
                {
                    ApplicationArea = All;
                    Caption = 'Id';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Caption = 'Address';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Caption = 'City';
                }

                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Post Code';
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                    Caption = 'Country';
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    Caption = 'Phone No.';
                }

            }
        }
    }
    procedure Load(var TmpCustomers: Record "Customer Demo Structured" temporary)
    begin
        Rec.Reset();
        Rec.DeleteAll();

        TmpCustomers.Reset();
        if TmpCustomers.FindSet() then
            repeat
                Rec.Copy(TmpCustomers, false);
                Rec.Insert();
            until TmpCustomers.Next() = 0;

        CurrPage.Update(false);
    end;

    procedure SaveCustomers()
    var
        Customer: Record Customer;
        CustTemp: Record "Customer Demo Structured" temporary;
        LineNo, LineIncrem : Integer;
    begin
        CustTemp.Copy(Rec, true);
        CustTemp.SetRange(Select, true);

        if CustTemp.FindSet() then
            repeat
                Customer.Init();
                Customer."No." := '';
                Customer.Validate(name, CustTemp."Customer Name");
                Customer.Validate("Address", CustTemp.Address);
                Customer.Validate("Country/Region Code", CustTemp.Country);

                CheckPostCode(CustTemp."Post Code", CustTemp.Country, CustTemp.City);

                Customer.Validate("Post Code", CustTemp."Post Code");
                Customer.Validate("City", CustTemp.City);
                Customer.Validate("Phone No.", CustTemp."Phone Number");
                Customer.Validate("Customer Posting Group", 'DOMESTIC');
                Customer.validate("Gen. Bus. Posting Group", 'DOMESTIC');
                Customer."Payment Terms Code" := 'COD';
                Customer.Insert(true);

            until CustTemp.Next() = 0;
    end;


    local procedure CheckPostCode(PostCode: Code[20]; Country: Code[10]; City: Text)
    var
        PostCodeRec: Record "Post Code";
    begin
        if PostCodeRec.Get(PostCode, City) = false then begin
            PostCodeRec.Init();
            PostCodeRec.Code := PostCode;
            PostCodeRec.City := City;
            PostCodeRec."Country/Region Code" := Country;
            PostCodeRec.Insert();
        end;
    end;
}