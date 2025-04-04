namespace Microsoft.Finance.PowerBIReports;

using Microsoft.Finance.GeneralLedger.Budget;

#pragma warning disable AS0125
#pragma warning disable AS0030
query 36960 "G/L Budget Entries - PBI API"
#pragma warning restore AS0030
#pragma warning restore AS0125
{
    Access = Internal;
    QueryType = API;
    Caption = 'Power BI G/L Budget Entries';
    APIPublisher = 'microsoft';
    APIGroup = 'analytics';
    APIVersion = 'v0.5';
    EntityName = 'generalLedgerBudgetEntry';
    EntitySetName = 'generalLedgerBudgetEntries';
    DataAccessIntent = ReadOnly;

    elements
    {
        dataitem(GLBudgetEntry; "G/L Budget Entry")
        {
            column(budgetName; "Budget Name")
            {
            }
            column(glAccountNo; "G/L Account No.")
            {
            }
            column(budgetDate; Date)
            {
            }
            column(budgetAmount; Amount)
            {
            }
            column(dimensionSetID; "Dimension Set ID")
            {
            }
            column(entryNo; "Entry No.")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    var
        PBIMgt: Codeunit "Finance Filter Helper";
        DateFilterText: Text;
    begin
        DateFilterText := PBIMgt.GenerateFinanceReportDateFilter();
        if DateFilterText <> '' then
            CurrQuery.SetFilter(budgetDate, DateFilterText);
    end;
}