codeunit 70190 "ABC Register Capability Cust"

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
        if not CopilotCapability.IsCapabilityRegistered(Enum::"Copilot Capability"::"Demo Customers Structured") then
            CopilotCapability.RegisterCapability(Enum::"Copilot Capability"::"Demo Customers Structured",
                 Enum::"Copilot Availability"::"Generally Available", LearnMoreUrlTxt);
    end;

}
