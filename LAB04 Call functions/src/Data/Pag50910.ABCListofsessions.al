page 50910 "ABC List of sessions"
{
    ApplicationArea = All;
    Caption = 'ABC List of sessions';
    PageType = List;
    SourceTable = "ABC Sessions";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.id)
                {
                    ToolTip = 'Specifies the value of the id field.', Comment = '%';
                }
                field("Session Title"; Rec."Session Title")
                {
                    ToolTip = 'Specifies the value of the Session Title field.', Comment = '%';
                }
                field(Speakers; rec."Speakers 1")
                {
                    ToolTip = 'Specifies the value of the Speakers field.', Comment = '%';
                }
                field(Speakers2; rec."Speakers 2")
                {
                    ToolTip = 'Specifies the value of the Speakers field.', Comment = '%';
                }
                field(Speakers3; rec."Speakers 3")
                {
                    ToolTip = 'Specifies the value of the Speakers field.', Comment = '%';
                }
                field(SessionLevel; Rec."Session Level")
                {
                    ToolTip = 'Specifies the value of the Level field.', Comment = '%';
                }
                field(SessionType; Rec."Session Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(TargetAudience; Rec."Target Audience")
                {
                    ToolTip = 'Specifies the value of the Target Audience field.', Comment = '%';
                }
                field(Day; Rec."Day")
                {
                    ToolTip = 'Specifies the value of the Day field.', Comment = '%';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ToolTip = 'Specifies the value of the Start Time field.', Comment = '%';
                }
            }
        }
    }
}