page 81100 "WS Ask Me AnyThing"
{
    PageType = PromptDialog;
    ApplicationArea = All;
    Caption = 'ABC Ask Me AnyThing';
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
                InstructionalText = 'Type your Business Central question here and click Generate to get an answer.';

            }
        }
        area(PromptOptions)
        {
            field(varTone; varTone)
            {
                ApplicationArea = All;
                Caption = 'Tone';

            }
        }
        area(Content)

        {
            field(Answer; AnswerText)
            {
                ApplicationArea = All;
                Caption = 'Answer';
                ToolTip = 'The answer to your question will be displayed here.';
                Editable = false;
                MultiLine = true;
                ShowCaption = false;
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
                    cuABCAIModule: Codeunit "ABC AI Module";
                begin
                    if PromptText = '' then
                        Error('Please enter a question.');

                    // Call the AI module to generate the answer
                    AnswerText := cuABCAIModule.Generate(PromptText);

                    AnswerText := @'Powered by: www.AprendeBusinessCentral.com
                                   
                                   ' + AnswerText;

                    if AnswerText = '' then
                        Error('No answer was generated. Please try again.');
                end;
            }
        }
        // PromptGuide
        area(PromptGuide)
        {
            action(Option1)
            {
                Caption = 'How can I [do this]?';
                ToolTip = 'Ask Copilot for help with a specific task.';

                trigger OnAction()
                begin

                    AnswerText := '';
                    PromptText := 'How can I [do this] in Business Central?';
                end;
            }
        }
    }

    var
        PromptText: Text;
        AnswerText: Text;
        varTone: Enum "ToneEnum";
}