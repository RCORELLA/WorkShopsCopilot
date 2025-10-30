page 50912 "Asking for sessions"
{
    Caption = 'Asking for Directions EMEA Sessions';
    PageType = PromptDialog;
    PromptMode = Prompt;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;
    Extensible = false;


    layout
    {
        area(Prompt)
        {
            field(SessionDescription; SessionDescription)
            {
                ShowCaption = false;
                MultiLine = true;
                InstructionalText = 'Tell me the speaker to know different sessions that he/she has at Directions EMEA';
            }
        }

        area(Content)
        {
            field(SessionInfo; sessionInfoResponse)
            {
                ShowCaption = false;
                MultiLine = true;

            }
        }
    }

    actions
    {
        area(SystemActions)
        {
            systemaction(Generate)
            {
                Tooltip = 'Find different sessions for a speaker';
                trigger OnAction()
                begin
                    if SessionDescription = '' then
                        Error('Please enter a speaker name');

                    sessionInfoResponse := AIModule.Generate(SessionDescription)
                end;
            }
            systemaction(Regenerate)
            {
                Caption = 'Regenerate';
                Tooltip = 'Regenerate Sessions';
                trigger OnAction()

                begin
                    sessionInfoResponse := AIModule.Generate(SessionDescription)
                end;
            }
            systemaction(Cancel)
            {
                ToolTip = 'Discard';
            }
            systemaction(Ok)
            {
                Caption = 'Accept Proposals';
                ToolTip = 'Accept';
            }
        }
    }

    var

        SessionDescription: Text;
        sessionInfoResponse: Text;

        AIModule: Codeunit "ABC AI Module CF";





}