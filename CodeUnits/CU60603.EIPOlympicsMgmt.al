codeunit 60600 "Olympics Mgmt."
{
    trigger OnRun()
    begin

    end;

    procedure GetOlympicsItems()
    var
        ItemRec: Record Item;
        IntYear: Integer;
        Type: Text[1];
        WinterOlympicsRec: Record "Winter Olympics";
        SummerOlympicsRec: Record "Summer Olympics";
        LocationFilter: Text[30];
    begin
        if WinterOlympicsRec.FindSet() then begin
            repeat
                WinterOlympicsRec.Delete();
            until WinterOlympicsRec.Next() = 0;
        end;

        if SummerOlympicsRec.FindSet() then begin
            repeat
                SummerOlympicsRec.Delete();
            until SummerOlympicsRec.Next() = 0;
        end;

        LocationFilter := 'NIEBIESKI';
        ItemRec.SetRange("Location Filter", LocationFilter);

        if ItemRec.FindSet() then
            repeat
                if StrLen(ItemRec."No.") = 6 then begin
                    if Evaluate(IntYear, CopyStr(ItemRec."No.", 1, 4)) then begin
                        Evaluate(Type, CopyStr(ItemRec."No.", 6, 1));

                        if Type = 'W' then begin
                            if not WinterOlympicsRec.Get(ItemRec."No.") then begin
                                WinterOlympicsRec.Init();
                                WinterOlympicsRec."No." := ItemRec."No.";
                                WinterOlympicsRec.Description := ItemRec.Description;
                                WinterOlympicsRec.Year := IntYear;
                                WinterOlympicsRec.Inventory := ItemRec.Inventory;
                                WinterOlympicsRec.Insert();
                                Message('Added item to Winter Olympics: %1', ItemRec."No.");
                            end else begin
                                WinterOlympicsRec.Description := ItemRec.Description;
                                WinterOlympicsRec.Year := IntYear;
                                WinterOlympicsRec.Inventory := ItemRec.Inventory;
                                WinterOlympicsRec.Modify();
                                Message('Updated item in Winter Olympics: %1', ItemRec."No.");
                            end;
                        end else if Type = 'S' then begin
                            if not SummerOlympicsRec.Get(ItemRec."No.") then begin
                                SummerOlympicsRec.Init();
                                SummerOlympicsRec."No." := ItemRec."No.";
                                SummerOlympicsRec.Description := ItemRec.Description;
                                SummerOlympicsRec.Year := IntYear;
                                SummerOlympicsRec.Inventory := ItemRec.Inventory;
                                SummerOlympicsRec.Insert();
                                Message('Added item to Summer Olympics: %1', ItemRec."No.");
                            end else begin
                                SummerOlympicsRec.Description := ItemRec.Description;
                                SummerOlympicsRec.Year := IntYear;
                                SummerOlympicsRec.Inventory := ItemRec.Inventory;
                                SummerOlympicsRec.Modify();
                                Message('Updated item in Summer Olympics: %1', ItemRec."No.");
                            end;
                        end else begin
                            Message('Skipping item due to invalid type: %1', ItemRec."No.");
                        end;
                    end;
                end;
            until ItemRec.Next() = 0;
    end;
}