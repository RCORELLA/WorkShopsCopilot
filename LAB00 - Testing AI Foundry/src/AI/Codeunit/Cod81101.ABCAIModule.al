codeunit 81101 "ABC AI Module"
{

    procedure Generate(UserPrompt: Text): Text
    var
        AzureOpenAI: Codeunit "Azure OpenAI";
        AOAIOperationResponse: Codeunit "AOAI Operation Response";
        AOAIChatCompletionParams: Codeunit "AOAI Chat Completion Params";
        AOAIChatMessages: Codeunit "AOAI Chat Messages";

        Result: Text;
    begin
        // Initialize the Azure OpenAI service
        // endpoint: https://your-openai-endpoint
        // apiKey: your-api-key
        // Deployment: gpt-4.1
        SetAuthorization(AzureOpenAI);



        // Set up the chat completion parameters
        // temperature 
        // maxTokens

        SetParameters(AOAIChatCompletionParams);

        // Set the Copilot capability for the Azure OpenAI service
        AzureOpenAI.SetCopilotCapability(Enum::"Copilot Capability"::"ABC Ask Me AnyThing");

        // Set the system meta prompt        
        AOAIChatMessages.SetPrimarySystemMessage(GetSystemMetaPrompt());

        // Add the user message to the chat messages
        AOAIChatMessages.AddUserMessage(GetUserPrompt(UserPrompt));

        // Add the tone option if it is set

        AzureOpenAI.GenerateChatCompletion(AOAIChatMessages, AOAIChatCompletionParams, AOAIOperationResponse);
        if AOAIOperationResponse.IsSuccess() then
            Result := AOAIChatMessages.GetLastMessage()
        else
            Result := AOAIOperationResponse.GetError() + ' - ' +
                 AOAIOperationResponse.GetStatusCode().ToText();
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
        Metaprompt := 'You are a helpful Business Central Support agent. Please provide only information related to Business Central. ' +
                      'If you do not know the answer, say "I do not know" and do not provide any other information. ' +
                      'Do not include any disclaimers or additional information. ' +
                      'Your responses should be concise and to the point.';
        exit(Metaprompt);
    end;


    local procedure GetUserPrompt(Prompt: Text): Text
    var
        DataTextBuilder: TextBuilder;

    begin
        // generating the prompt for the AI
        DataTextBuilder.AppendLine('You are an expert Business Central Support agent.');
        DataTextBuilder.AppendLine('You can review the information from the website https://learn.microsoft.com/es-es/dynamics365/business-central/');

        DataTextBuilder.AppendLine('This is the user question:');
        DataTextBuilder.AppendLine(Prompt);
        DataTextBuilder.AppendLine('You need to generate a step to step guide to help the user with their question.');

        exit(DataTextBuilder.ToText());
    end;

    local procedure SetAuthorization(var AzureOpenAI: Codeunit "Azure OpenAI")
    var
        Endpoint: Text;
        Deployment: Text;
        Apikey: Text;
    begin
        if not recAISetup.get() then
            Error('No has configurado el acceso');

        Endpoint := recAISetup.EndPoint;
        Deployment := recAISetup.Deployment;
        Apikey := recAISetup."API Key";

        AzureOpenAI.SetAuthorization(Enum::"AOAI Model Type"::"Chat Completions", Endpoint, Deployment, Apikey);
    end;



    var
        recAISetup: Record "ABC AI Setup";
        EndPoint: Text;
        Deployment: Text;
        ApiKey: Text;

}