// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Inventory.Intrastat;

using Microsoft.Inventory.Tracking;

pageextension 4829 "Intr. Rep. Ser. No. Info Card" extends "Serial No. Information Card"
{
    layout
    {
        addafter(Blocked)
        {
            field("Country/Region Code"; Rec."Country/Region Code")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()
    begin
        IntrReportTrackingMgt.SetCountryRegionCode(TrackingSpecification);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Country/Region Code" := IntrReportTrackingMgt.GetCurrentCountryRegionCode();
    end;

    trigger OnClosePage()
    begin
        IntrReportTrackingMgt.ClearCountryRegionCode();
    end;

    var
        IntrReportTrackingMgt: Codeunit IntrastatReportItemTracking;
}