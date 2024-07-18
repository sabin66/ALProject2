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
                var
                    CityToOpen: Text;
                begin
                    CityToOpen := Rec.City;
                    Hyperlink('https://maps.google.com/?q=' + CityToOpen);
                end;

            }
            action("Get Information")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    CityToOpen: Text;
                begin
                    CityToOpen := Rec.City;
                    Hyperlink('https://www.google.com/search?q=' + CityToOpen);
                end;

            }
            action("Get Olympics")
            {
                trigger OnAction()
                var
                    WinterOlympic: Record "Winter Olympics";
                    SummerOlympic: Record "Summer Olympics";
                    Olympic: Record "Olympic";
                begin
                    if WinterOlympic.FindSet() then
                        repeat
                            Olympic.Init();
                            Olympic."No." := WinterOlympic."No.";
                            if Olympic.Insert() then;
                            Olympic.Year := WinterOlympic.Year;
                            Olympic.Type := Olympic.Type::Zimowa;
                            Olympic.Modify();
                        until WinterOlympic.Next() = 0;
                    if SummerOlympic.FindSet() then
                        repeat
                            Olympic.Init();
                            Olympic."No." := SummerOlympic."No.";
                            if Olympic.Insert() then;
                            Olympic.City := CopyStr(SummerOlympic.Description, 1, StrPos(SummerOlympic.Description, ' '));
                            Olympic.Name := 'Summer Olympics in ' + Olympic.City;
                            Olympic.Year := SummerOlympic.Year;
                            Olympic.Type := Olympic.Type::Letnia;
                            Olympic.Modify();
                        until SummerOlympic.Next() = 0;
                    CurrPage.Update();
                end;
            }
            action("Delete All Olympics")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    OlympicRec: Record "Olympic";
                begin
                    if OlympicRec.FindSet() then
                        repeat
                            OlympicRec.Delete();
                        until OlympicRec.Next() = 0;
                    Message('All Olympic records have been deleted.');
                end;
            }
        }
    }
}
