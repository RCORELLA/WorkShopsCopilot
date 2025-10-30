pageextension 70190 "ABC Customer Creation 2" extends "Customer List"
{

    actions
    {
        // Add changes to page actions here
        addlast(Prompting)
        {
            action(AskMeAnyThing)
            {
                ApplicationArea = All;
                Caption = 'Creating demo customers structured';
                ToolTip = 'Ask me anything about creating demo customers';
                Image = SparkleFilled;


                trigger OnAction()
                var
                    DemoCustomerPage: Page "creating Demo Cust structured";
                begin
                    DemoCustomerPage.RunModal();
                end;
            }
        }
    }

}