page 60605 "Olympic Picture"
{
    ApplicationArea = All;
    SourceTable = "Olympic";
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Image; Rec.Image)
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
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    tmpinstream: InStream;
                    tmpfile: Text;
                begin
                    UploadIntoStream('Import picture', '', 'All Files (*.*)|*.*', tmpfile, tmpinstream);
                    Rec.Image.ImportStream(tmpinstream, tmpfile);
                    Rec.Modify();
                end;
            }
            action(ExportPicture)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    tmpoutstream: OutStream;
                    tmpinstream: InStream;
                    tmpfile: Text;
                begin
                    DownloadFromStream(tmpinstream, 'Export picture', '', 'All Files (*.*)|*.*', tmpfile);
                    Rec.Image.ExportStream(tmpoutstream);
                    Rec.Modify();
                end;
            }
        }
    }
}
