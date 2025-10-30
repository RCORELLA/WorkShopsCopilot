codeunit 50912 "GetSessionsInfo" implements "AOAI Function"
{

    var
        lblToolName: label 'GetSessionsInfo', Locked = true;

    procedure GetPrompt() ToolJObj: JsonObject
    var
        definition: Text;
    begin
        //         '{
        //     "type": "function",
        //     "function": {
        //         "name": "GetDirectionsSessionsData",
        //         "description": "Returns information about Directions EMEA sessions, levels and speakers.",
        //         "parameters": {
        //             "type": "object",
        //             "properties": {
        //                 "speaker": {
        //                     "type": "string",
        //                     "description": "The speaker name to filter the sessions."
        //                 },
        //                 "topic": {
        //                     "type": "string",
        //                     "description": "The topic to filter the sessions."
        //                 },
        //                 "level": {
        //                     "type": "string",
        //                     "description": "The level to filter the sessions."
        //                 }
        //             },
        //             "required": ["speaker"]
        //         }
        //     }
        // }'

        definition := @'{
                        "type": "function",
                        "function": {
                            "name": "GetSessionsInfo",
                            "description": "Returns information about Directions EMEA sessions, levels and speakers.",
                            "parameters": {
                                "type": "object",
                                "properties": {
                                    "speaker": {
                                        "type": "string",
                                        "description": "The speaker name to filter the sessions."
                                    }
                                },
                                "required": ["speaker"]
                            }
                        }
                    }';

        ToolJObj.ReadFrom(definition);
        exit(ToolJObj);
    end;

    procedure Execute(Arguments: JsonObject): Variant
    var
        speaker: Text;
    begin
        speaker := Arguments.GetText('speaker');
        if speaker = '' then
            error('We need a speaker name');

        exit(findsessionsfromSpeaker(speaker))
    end;


    local procedure FindSessionsFromSpeaker(Speaker: Text): Text
    var
        sessions: Record "ABC Sessions";
        SessionsInfo: TextBuilder;
    begin

        sessions.FindSet();
        repeat
            sessions."String Speakers" := sessions."Speakers 1" + ';' + sessions."Speakers 2" + ';' + sessions."Speakers 3";
            sessions.modify;
        until sessions.Next() = 0;

        // filter speaker 1
        sessions.Reset();
        sessions.SetFilter("string speakers", StrSubstNo('@*%1*', Speaker));
        if not sessions.IsEmpty then begin
            SessionsInfo.AppendLine(StrSubstNo('Found %1 sessions.', sessions.Count));
            sessions.FindSet();
            repeat
                SessionsInfo.AppendLine('## Session information');
                SessionsInfo.AppendLine(StrSubstNo('Session Title: %1', Sessions."Session Title"));
                SessionsInfo.AppendLine(StrSubstNo('Session speaker 1: %1', sessions."Speakers 1"));
                if sessions."Speakers 2" <> '' then
                    SessionsInfo.AppendLine(StrSubstNo('Session speaker 2: %1', sessions."Speakers 2"));
                if sessions."Speakers 3" <> '' then
                    SessionsInfo.AppendLine(StrSubstNo('Session speaker 3: %1', sessions."Speakers 3"));

                SessionsInfo.AppendLine('Session level: ' + sessions."Session Level");
                SessionsInfo.AppendLine('Session type:' + sessions."Session Type");

            until sessions.Next() = 0;
        end else begin
            SessionsInfo.AppendLine('No sessions are found');
        end;

        exit(SessionsInfo.ToText())

    end;




    procedure GetName(): Text
    begin
        exit(lblToolName);
    end;


}