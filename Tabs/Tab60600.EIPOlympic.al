table 60600 "Olympic"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Type; Option)
        {
            OptionMembers = "Letnia","Zimowa";
            DataClassification = ToBeClassified;
        }
        field(3; Name; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Year; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; City; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Post Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Country/Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Fun Fact"; Text[250])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(9; Image; Media)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}