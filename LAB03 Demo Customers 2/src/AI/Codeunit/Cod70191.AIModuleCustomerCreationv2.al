codeunit 70191 "AI Module Customer Creation v2"

{

    trigger OnRun()
    begin
        GenerateTempCustomers();
    end;

    procedure SetUserPrompt(InputUserPrompt: Text)
    begin
        UserPrompt := InputUserPrompt;
    end;

    procedure GetResult(var tmpCustomer2: Record "Customer Demo Structured" temporary)
    begin
        tmpCustomer2.Copy(TmpCustomer, true);
    end;

    internal procedure GetCompletionResult(): Text
    begin
        exit(CompletionResult);
    end;

    local procedure GenerateTempCustomers()
    var
        InStr: InStream;
        OutStr: OutStream;
        TmpText: Text;
        JResTok: JsonToken;
        JResCustTok: JsonToken;
        JsonCustArray: JsonArray;
        i, LineNo : Integer;
        JCustomer: JsonToken;
        NameToken: JsonToken;
        AddressToken: JsonToken;
        PostCodeToken: JsonToken;
        CityToken: JsonToken;
        CountryToken: JsonToken;
        PhoneToken: JsonToken;
    begin
        CompletionResult := '';
        TmpText := Chat(GetSystemPrompt(), GetFinalUserPrompt(UserPrompt));

        JResTok.ReadFrom(TmpText);
        JResTok.AsObject().Get('customers', JResCustTok);
        JsonCustArray := JResCustTok.AsArray();

        if JsonCustArray.Count() > 0 then begin
            LineNo := 1;
            for i := 0 to JsonCustArray.Count() - 1 do begin
                JsonCustArray.Get(i, JCustomer);
                TmpCustomer.Init();
                TmpCustomer.id := LineNo;

                if JCustomer.AsObject().Get('Name', NameToken) then
                    TmpCustomer."Customer Name" := UpperCase(CopyStr(NameToken.AsValue().AsText(), 1, MaxStrLen(TmpCustomer."customer Name")));

                if JCustomer.AsObject().Get('address', AddressToken) then
                    TmpCustomer.Address := CopyStr(AddressToken.AsValue().AsText(), 1, MaxStrLen(TmpCustomer.Address));

                if JCustomer.AsObject().Get('postcode', PostCodeToken) then
                    TmpCustomer."Post Code" := CopyStr(PostCodeToken.AsValue().AsText(), 1, MaxStrLen(TmpCustomer."Post Code"));

                if JCustomer.AsObject().Get('city', CityToken) then
                    TmpCustomer.City := CityToken.AsValue().AsText();

                if JCustomer.AsObject().Get('country', CountryToken) then
                    TmpCustomer.Country := CopyStr(CountryToken.AsValue().AsText(), 1, MaxStrLen(TmpCustomer.Country));

                if JCustomer.AsObject().Get('phoneNo', PhoneToken) then
                    TmpCustomer."Phone Number" := UpperCase(CopyStr(PhoneToken.AsValue().AsText(), 1, MaxStrLen(TmpCustomer."Phone Number")));

                TmpCustomer.Insert();
                LineNo += 1;
            end;
        end;
    end;





    //procedure Generate(UserPrompt: Text): Text
    procedure Chat(ChatSystemPrompt: Text; ChatUserPrompt: Text): Text
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
        SecretManagement.SetAuthorization(AzureOpenAI);

        // Set up the chat completion parameters
        // temperature 
        // maxTokens

        SetParameters(AOAIChatCompletionParams);

        // Set the Copilot capability for the Azure OpenAI service
        AzureOpenAI.SetCopilotCapability(Enum::"Copilot Capability"::"Demo Customers Structured");

        // Set the system meta prompt        
        AOAIChatMessages.SetPrimarySystemMessage(ChatSystemPrompt);

        // Add the user message to the chat messages
        AOAIChatMessages.AddUserMessage(ChatUserPrompt);

        // Add the tone option if it is set


        AzureOpenAI.GenerateChatCompletion(AOAIChatMessages, AOAIChatCompletionParams, AOAIOperationResponse);
        if AOAIOperationResponse.IsSuccess() then begin
            Result := AOAIChatMessages.GetLastMessage();
            CompletionResult := Result;
        end;

        exit(Result);
    end;



    // Add the parameters for the chat completion request

    local procedure SetParameters(var AOAIChatCompletionParams: Codeunit "AOAI Chat Completion Params")
    begin
        //AOAIChatCompletionParams.SetJsonMode(true);
        AOAIChatCompletionParams.SetMaxTokens(3500);
        AOAIChatCompletionParams.SetTemperature(0);
        AOAIChatCompletionParams.SetJsonMode(true);
    end;




    local procedure GetSystemPrompt() SystemPrompt: Text

    begin
        SystemPrompt += 'The user will provide a country or a city. Your task is to create a list of demo customers for Business Central from that country or city.';
        SystemPrompt += ' Try to suggest customers with Company Names that are common in that country or city.';
        SystemPrompt += ' The output should be in json with customers array as a root node.';
        SystemPrompt += ' Each customer should be a json object with the following fields:';
        SystemPrompt += ' Name - customer name, address - only street and number of the customer, postcode - post code, city - city, country - country in ISO code, phoneNo - phone number.';

    end;


    local procedure GetFinalUserPrompt(InputUserPrompt: Text) FinalUserPrompt: Text
    var
        DataTextBuilder: TextBuilder;
    begin
        DataTextBuilder.AppendLine('You are an expert Business Central Support agent.');
        DataTextBuilder.AppendLine('You are going to help the user to create demo customers in Business Central.');

        DataTextBuilder.AppendLine('According with the user help:');
        DataTextBuilder.AppendLine(InputUserPrompt);
        DataTextBuilder.AppendLine('You will generate a number demo customers for Business Central.');
        DataTextBuilder.AppendLine('You will generate the customers with the following characteristics:');
        DataTextBuilder.AppendLine('1. We will have a Customer Name');
        DataTextBuilder.AppendLine('2. We will have an invented Address, with Address, number, city, post code and country');
        DataTextBuilder.AppendLine('3. We will have a Phone number');
        DataTextBuilder.AppendLine('The maximum number of customers to create is 10.');

        DataTextBuilder.AppendLine('You will generate the customers based on the user request, such as "Create 10 Customers from Spain"');
        exit(DataTextBuilder.ToText());
    end;






    var
        SecretManagement: Codeunit "ABC Secrets manager";
        TmpCustomer: Record "Customer demo structured" temporary;
        CompletionResult: Text;
        UserPrompt: Text;

}