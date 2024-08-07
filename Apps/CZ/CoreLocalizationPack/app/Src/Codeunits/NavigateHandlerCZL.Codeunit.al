﻿// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Foundation.Navigate;

using Microsoft.Finance;

#pragma warning disable AL0432
codeunit 31044 "Navigate Handler CZL"
{
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        EETEntryCZL: Record "EET Entry CZL";

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateFindRecords', '', false, false)]
    local procedure OnAfterNavigateFindRecords(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text)
    begin
        FindEETEntries(DocumentEntry, DocNoFilter);
    end;

    local procedure FindEETEntries(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text)
    begin
        if EETEntryCZL.ReadPermission() then begin
            EETEntryCZL.Reset();
            EETEntryCZL.SetCurrentKey("Document No.");
            EETEntryCZL.SetFilter("Document No.", DocNoFilter);
            DocumentEntry.InsertIntoDocEntry(Database::"EET Entry CZL", Enum::"Document Entry Document Type"::Quote,
                EETEntryCZL.TableCaption(), EETEntryCZL.Count());
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnBeforeShowRecords', '', false, false)]
    local procedure OnBeforeShowRecords(var TempDocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text; var IsHandled: Boolean)
    begin
        case TempDocumentEntry."Table ID" of
            Database::"EET Entry CZL":
                begin
                    EETEntryCZL.Reset();
                    EETEntryCZL.SetFilter("Document No.", DocNoFilter);
                    if TempDocumentEntry."No. of Records" = 1 then
                        Page.Run(Page::"EET Entry Card CZL", EETEntryCZL)
                    else
                        Page.Run(0, EETEntryCZL);
                    IsHandled := true;
                end;
        end;
    end;
}
