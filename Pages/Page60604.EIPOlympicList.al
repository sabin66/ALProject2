page 60604 "Olympic List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Olympic";
    CardPageId = "Olympic Card";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                }
                field("Year"; Rec."Year")
                {
                    ApplicationArea = All;
                }
                field("City"; Rec."City")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Show map")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin

                end;

            }
            action("Get Information")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin

                end;

            }
            action("Get Olympics")
            {
                trigger OnAction()
                var
                    WinterOlympic: Record "Winter Olympics";
                    SummerOlympic: Record "Summer Olympics";
                begin
                    if WinterOlympic.FindSet() then
                        repeat
                            Rec.Init();
                            Rec."No." := WinterOlympic."No.";
                            Rec.Insert();
                            Rec.Year := WinterOlympic.Year;
                            Rec.Type := Rec.Type::Zimowa;
                            Rec.Modify();
                        until WinterOlympic.Next() = 0;
                    if SummerOlympic.FindSet() then
                        repeat
                            Rec.Init();
                            Rec."No." := SummerOlympic."No.";
                            Rec.Insert();
                            Rec.Year := SummerOlympic.Year;
                            //CurrPage.SetSelectionFilter();
                            Rec.Type := Rec.Type::Letnia;
                            Rec.Modify();
                        until SummerOlympic.Next() = 0;
                end;
            }
        }
    }
}
