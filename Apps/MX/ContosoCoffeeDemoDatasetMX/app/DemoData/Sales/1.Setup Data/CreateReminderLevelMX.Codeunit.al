codeunit 14127 "Create Reminder Level MX"
{
    SingleInstance = true;
    EventSubscriberInstance = Manual;
    InherentEntitlements = X;
    InherentPermissions = X;

    [EventSubscriber(ObjectType::Table, Database::"Reminder Level", 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertReminderLevel(var Rec: Record "Reminder Level")
    var
        CreateReminderTerms: Codeunit "Create Reminder Terms";
    begin
        case Rec."Reminder Terms Code" of
            CreateReminderTerms.Domestic():
                begin
                    if Rec."No." = 1 then
                        ValidateRecordFields(Rec, 70);
                    if Rec."No." = 2 then
                        ValidateRecordFields(Rec, 139);
                    if Rec."No." = 3 then
                        ValidateRecordFields(Rec, 207);
                end;
        end;
    end;

    procedure ValidateRecordFields(var ReminderLevel: Record "Reminder Level"; AdditionalFee: Decimal)
    begin
        ReminderLevel.Validate("Additional Fee (LCY)", AdditionalFee);
    end;
}