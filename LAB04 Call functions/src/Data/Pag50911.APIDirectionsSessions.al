namespace LABCallfunctions.LABCallfunctions;

page 50911 "API Directions Sessions"
{
    APIGroup = 'directions';
    APIPublisher = 'rcb';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'apiDirectionsSessions';
    DelayedInsert = true;
    EntityName = 'session';
    EntitySetName = 'sessions';
    PageType = API;
    SourceTable = "ABC Sessions";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.id)
                {
                    Caption = 'id';
                }
                field(sessionTitle; Rec."Session Title")
                {
                    Caption = 'Session Title';
                }
                field(speakers1; Rec."Speakers 1")
                {
                    Caption = 'Speakers 1';
                }
                field(speakers2; Rec."Speakers 2")
                {
                    Caption = 'Speakers 2';
                }
                field(speakers3; Rec."Speakers 3")
                {
                    Caption = 'Speakers 3';
                }
                field(sessionType; Rec."Session Type")
                {
                    Caption = 'Session Type';
                }
                field(sessionLevel; Rec."Session Level")
                {
                    Caption = 'Session Level';
                }
                field(targetAudience; Rec."Target Audience")
                {
                    Caption = 'Target Audience';
                }
                field(day; Rec.Day)
                {
                    Caption = 'Day';
                }
                field(startTime; Rec."Start Time")
                {
                    Caption = 'Start Time';
                }
            }
        }
    }
}
