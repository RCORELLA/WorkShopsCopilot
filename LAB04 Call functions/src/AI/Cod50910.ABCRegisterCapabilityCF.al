codeunit 50910 "ABC Register Capability CF"

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
        if not CopilotCapability.IsCapabilityRegistered(Enum::"Copilot Capability"::"Call Function") then
            CopilotCapability.RegisterCapability(Enum::"Copilot Capability"::"Call Function",
                 Enum::"Copilot Availability"::"Generally Available", LearnMoreUrlTxt);
    end;

}
