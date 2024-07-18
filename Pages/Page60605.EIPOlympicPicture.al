page 60605 "Olympic Picture"
{
    ApplicationArea = All;
    SourceTable = "Olympic";
    PageType = CardPart;

    layout
    {
        area(Content)
        {
            field(Image; Rec.Image)
            {
                ApplicationArea = All;
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
                    InStr: InStream;
                    OutStr: OutStream;
                    TempBlob: Codeunit "Temp Blob";
                    FileName: Text;
                begin
                    FileName := 'ExportedPicture.png';

                    // Create an OutStream for the Temp Blob
                    TempBlob.CreateOutStream(OutStr, TextEncoding::Windows);

                    // Export the image to the OutStream
                    Rec.Image.ExportStream(OutStr);

                    // Create an InStream from the Temp Blob
                    TempBlob.CreateInStream(InStr, TextEncoding::Windows);

                    // Download the file to the client
                    DownloadFromStream(InStr, 'Export picture', '', 'PNG Files (*.png)|*.png', FileName);

                    Message('Picture exported successfully.');
                end;
            }
        }
    }
}

