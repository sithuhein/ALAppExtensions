codeunit 31106 "Upgrade Tag Definitions CZP"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Upgrade Tag", 'OnGetPerDatabaseUpgradeTags', '', false, false)]
    local procedure RegisterPerDatabaseTags(var PerDatabaseUpgradeTags: List of [Code[250]])
    begin
        PerDatabaseUpgradeTags.Add(GetDataVersion173PerDatabaseUpgradeTag());
        PerDatabaseUpgradeTags.Add(GetDataVersion174PerDatabaseUpgradeTag());
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Upgrade Tag", 'OnGetPerCompanyUpgradeTags', '', false, false)]
    local procedure RegisterPerCompanyTags(var PerCompanyUpgradeTags: List of [Code[250]])
    begin
        PerCompanyUpgradeTags.Add(GetDataVersion173PerCompanyUpgradeTag());
        PerCompanyUpgradeTags.Add(GetDataVersion174PerCompanyUpgradeTag());
    end;

    procedure GetDataVersion173PerDatabaseUpgradeTag(): Code[250]
    begin
        exit('CZP-UpgradeCashDeskLocalizationForCzech-PerDatabase-17.3');
    end;

    procedure GetDataVersion173PerCompanyUpgradeTag(): Code[250]
    begin
        exit('CZP-UpgradeCashDeskLocalizationForCzech-PerCompany-17.3');
    end;

    procedure GetDataVersion174PerDatabaseUpgradeTag(): Code[250]
    begin
        exit('CZP-UpgradeCashDeskLocalizationForCzech-PerDatabase-17.4');
    end;

    procedure GetDataVersion174PerCompanyUpgradeTag(): Code[250]
    begin
        exit('CZP-UpgradeCashDeskLocalizationForCzech-PerCompany-17.4');
    end;
}