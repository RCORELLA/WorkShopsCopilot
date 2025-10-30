codeunit 50911 "ABC AI Module CF"
{

    procedure Generate(UserPrompt: Text): Text
    var
        AzureOpenAI: Codeunit "Azure OpenAI";
        AOAIOperationResponse: Codeunit "AOAI Operation Response";
        AOAIChatCompletionParams: Codeunit "AOAI Chat Completion Params";
        AOAIChatMessages: Codeunit "AOAI Chat Messages";
        GetSessionsInfo: codeunit GetSessionsInfo;

        Result: Text;
    begin
        // Initialize the Azure OpenAI service
        // endpoint: https://your-openai-endpoint
        // apiKey: your-api-key
        // Deployment: gpt-4.1
        SecretManagement.SetAuthorization(AzureOpenAI);

        // Set up the chat completion parameters
        // temperature 
        // maxTokens

        SetParameters(AOAIChatCompletionParams);

        // Set the Copilot capability for the Azure OpenAI service
        AzureOpenAI.SetCopilotCapability(Enum::"Copilot Capability"::"Call Function");

        // Set the system meta prompt        
        AOAIChatMessages.SetPrimarySystemMessage(GetSystemMetaPrompt());

        // Add the user message to the chat messages
        AOAIChatMessages.AddUserMessage(GetUserPrompt(UserPrompt));

        // Add tool
        AOAIChatMessages.AddTool(GetSessionsInfo);
        // preference
        AOAIChatMessages.SetToolInvokePreference("AOAI Tool Invoke Preference"::Automatic);
        // Set tool choice to added tool
        AOAIChatMessages.SetToolChoice('auto');


        AzureOpenAI.GenerateChatCompletion(AOAIChatMessages, AOAIChatCompletionParams, AOAIOperationResponse);
        if AOAIOperationResponse.IsSuccess() then
            Result := AOAIChatMessages.GetLastMessage();
        exit(Result);
    end;




    // Add the parameters for the chat completion request

    local procedure SetParameters(var AOAIChatCompletionParams: Codeunit "AOAI Chat Completion Params")
    begin
        //AOAIChatCompletionParams.SetJsonMode(true);
        AOAIChatCompletionParams.SetMaxTokens(3500);
        AOAIChatCompletionParams.SetTemperature(0);
    end;


    local procedure GetSystemMetaPrompt(): Text
    var
        MetaPrompt: Text;
    begin
        Metaprompt := @'You are a helpful Business Central Support agent.';
        exit(Metaprompt);
    end;


    local procedure GetUserPrompt(Prompt: Text): Text
    var


        userPrompttmp: Text;
    begin
        // generating the prompt for the AI
        userPrompttmp := 'You need to read information from Business Central.'
                        + Prompt +
                       @' IMPORTANT: If the user ask for directions EMEA sessions, you first need to have the speaker name and
                           call the function GetSessionsInfo to get the information from the sessions, levels or speakers
                           and then use that information to answer the user question.
                           Available tools:
                            - GetSessionsInfo: to get the information from the directions sessions, levels or speakers.';



        exit(userPrompttmp);
    end;




    var
        SecretManagement: Codeunit "ABC Secrets manager";

}