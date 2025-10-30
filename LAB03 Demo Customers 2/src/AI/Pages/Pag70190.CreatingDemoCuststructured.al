page 70190 "Creating Demo Cust structured"
{
    PageType = PromptDialog;
    ApplicationArea = All;
    Caption = 'RCB Creating Demo Customers';
    PromptMode = Prompt;
    Extensible = false;


    layout
    {
        area(Prompt)
        {
            field(PromptText; PromptText)
            {
                ApplicationArea = All;
                Caption = 'What do you want to ask?';
                ToolTip = 'Enter your question here.';
                Editable = true;
                ShowCaption = false;
                MultiLine = true;
                InstructionalText = 'Introduce here the number and country of customers you want to create. For example: "Create 10 Customers from Spain" or "Create 5 American Customers".';

            }
        }
        area(PromptOptions)
        {

        }
        area(Content)
        {
            part(CustTempSubPage; "Copilot Demo Cust Sub Page")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(SystemActions)
        {
            systemaction(Generate)
            {
                trigger OnAction()
                var
                    cuABCAIModule: Codeunit "AI Module Customer Creation v2";
                begin
                    if PromptText = '' then
                        Error('Please enter a question.');

                    // Call the AI module to generate the answer
                    RunGeneration();


                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        CurrPage.Caption := 'Create Demo Customers with Copilot';
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = CloseAction::OK then begin
            CurrPage.CustTempSubPage.Page.SaveCustomers();
        end;
    end;

    local procedure RunGeneration()
    var
        InStr: InStream;
        Attempts: Integer;
    begin
        CurrPage.Caption := PromptText;
        GenDemoCust.SetUserPrompt(PromptText);


        TmpDemoCust.Reset();
        TmpDemoCust.DeleteAll();

        Attempts := 0;
        while TmpDemoCust.IsEmpty and (Attempts < 5) do begin
            if GenDemoCust.Run() then
                GenDemoCust.GetResult(TmpDemoCust);
            Attempts += 1;
        end;

        if (Attempts < 5) then begin
            Load(TmpDemoCust);
        end else
            Error('Something went wrong. Please try again. ' + GetLastErrorText());
    end;



    procedure Load(var TmpCustProposal: Record "Customer Demo Structured" temporary)
    begin
        CurrPage.CustTempSubPage.Page.Load(tmpCustProposal);

        CurrPage.Update(false);
    end;



    var
        PromptText: Text;

        GenDemoCust: Codeunit "AI Module Customer Creation v2";
        TmpDemoCust: Record "Customer Demo Structured" temporary;
}