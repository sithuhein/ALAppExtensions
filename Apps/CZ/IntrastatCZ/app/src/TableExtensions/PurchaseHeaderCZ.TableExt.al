// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Inventory.Intrastat;

using Microsoft.Purchases.Document;

tableextension 31328 "Purchase Header CZ" extends "Purchase Header"
{
    fields
    {
        field(31305; "Physical Transfer CZ"; Boolean)
        {
            Caption = 'Physical Transfer';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Physical Transfer CZ" then
                    if not ("Document Type" in ["Document Type"::"Credit Memo", "Document Type"::"Return Order"]) then
                        FieldError("Document Type");
                UpdatePurchLinesByFieldNo(FieldNo("Physical Transfer CZ"), CurrFieldNo <> 0);
            end;
        }
    }

    procedure CheckIntrastatMandatoryFieldsCZ()
    var
        IntrastatReportSetup: Record "Intrastat Report Setup";
    begin
        if not (Ship or Receive) then
            exit;
        if IsIntrastatTransactionCZL() and ShipOrReceiveInventoriableTypeItemsCZL() then begin
            IntrastatReportSetup.Get();
            if IntrastatReportSetup."Transaction Type Mandatory CZ" then
                TestField("Transaction Type");
            if IntrastatReportSetup."Transaction Spec. Mandatory CZ" then
                TestField("Transaction Specification");
            if IntrastatReportSetup."Transport Method Mandatory CZ" then
                TestField("Transport Method");
            if IntrastatReportSetup."Shipment Method Mandatory CZ" then
                TestField("Shipment Method Code");
        end;
    end;
}