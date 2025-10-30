codeunit 81100 "ABC Register Capability"

{
    Subtype = Install;
    InherentEntitlements = X;
    InherentPermissions = X;
    Access = Internal;

    trigger OnInstallAppPerDatabase()
    begin
        RegisterCapability();
    end;

    local procedure RegisterCapability()
    var
        CopilotCapability: Codeunit "Copilot Capability";
        LearnMoreUrlTxt: Label 'https://blog.msdyn365bc.es', Locked = true;
    begin
        if not CopilotCapability.IsCapabilityRegistered(Enum::"Copilot Capability"::"ABC Ask Me AnyThing") then
            CopilotCapability.RegisterCapability(Enum::"Copilot Capability"::"ABC Ask Me AnyThing",
                 Enum::"Copilot Availability"::"Generally Available", LearnMoreUrlTxt);
    end;

}
