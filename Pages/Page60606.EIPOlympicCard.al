page 60606 "Olympic Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Olympic";
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(Info)
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
            group(Information)
            {
                field("Fun Fact"; Rec."Fun Fact")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part("Olympic Picture"; "Olympic Picture")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
                Visible = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Fun Fact")
            {
                Image = Import;
                ApplicationArea = All;
                Caption = 'Import';

                trigger OnAction()
                var
                    tmpinstream: InStream;
                    tmpfile: Text;
                    funFactText: Text[1024];
                begin
                    if UploadIntoStream('Import text', '', 'All Files (*.*)|*.*', tmpfile, tmpinstream) then begin
                        tmpinstream.ReadText(funFactText);
                        Rec."Fun Fact" := funFactText;
                        Rec.Modify(true);
                        Message('Fun Fact imported successfully.');
                    end else
                        exit;
                end;
            }
            action("Export Fun Fact")
            {
                Image = Export;
                ApplicationArea = All;
                Caption = 'Export';

                trigger OnAction()
                var
                    InStr: InStream;
                    OutStr: OutStream;
                    TempBlob: Codeunit "Temp Blob";
                    FileName: Text;
                begin
                    FileName := 'FunFact.txt';
                    TempBlob.CreateOutStream(OutStr, TextEncoding::Windows);

                    OutStr.WriteText(Rec."Fun Fact");

                    TempBlob.CreateInStream(InStr, TextEncoding::Windows);
                    DownloadFromStream(InStr, 'Export Fun Fact', '', '', FileName);

                    Message('Fun Fact exported successfully.');
                end;
            }

            action("Clear Fun Fact")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec."Fun Fact" := '';
                    Rec.Modify(true);
                    Message('Fun Fact cleared.');
                end;
            }
        }
    }
}
