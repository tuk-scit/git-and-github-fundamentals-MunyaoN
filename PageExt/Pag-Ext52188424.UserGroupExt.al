pageextension 52188424 "User Group Ext" extends "User Groups"
{

    layout
    {
        addafter(Name)
        {
            field(Type; Type)
            {
                ApplicationArea = Basic;
            }
        }

    }

}


