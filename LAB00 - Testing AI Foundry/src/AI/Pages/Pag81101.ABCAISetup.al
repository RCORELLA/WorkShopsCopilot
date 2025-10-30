page 81101 "ABC AI Setup"
{
    ApplicationArea = All;
    Caption = 'ABC AI Setup';
    PageType = Card;
    UsageCategory = Tasks;
    SourceTable = "ABC AI Setup";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(EndPoint; Rec.EndPoint)
                {
                    ToolTip = 'Specifies the value of the EndPoint field.', Comment = '%';
                }
                field("API Key"; Rec."API Key")
                {
                    ToolTip = 'Specifies the value of the API Key field.', Comment = '%';
                }
                field(Deployment; Rec.Deployment)
                {
                    ToolTip = 'Specifies the value of the Deployment field.', Comment = '%';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        recSetup: Record "ABC AI Setup";
    begin
        if not recSetup.Get('') then begin
            recSetup.Init();
            recSetup.Insert();
        end;
        rec := recSetup
    end;

}
