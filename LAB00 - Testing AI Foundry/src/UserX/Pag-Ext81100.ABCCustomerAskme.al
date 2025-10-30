pageextension 81100 "ABC Customer Askme" extends "Customer Card"
{


    actions
    {
        // Add changes to page actions here
        addlast(Prompting)
        {
            action(AskMeAnyThing)
            {
                ApplicationArea = All;
                Caption = 'ABC Ask Me AnyThing';
                ToolTip = 'Open the Ask Me AnyThing dialog to ask questions.';
                Image = SparkleFilled;


                trigger OnAction()
                var
                    AskMeDialog: Page "WS Ask Me AnyThing";
                begin
                    AskMeDialog.RunModal();
                end;
            }
        }
    }

}