page 60601 "Winter Olympics Page"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Winter Olympics";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Year; Rec.Year)
                {
                }
                field(Inventory; Rec.Inventory)
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Get Olympics Items")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    OlympicsManagement: Codeunit "Olympics Mgmt.";
                begin
                    OlympicsManagement.GetOlympicsItems();
                end;
            }
        }
    }
}