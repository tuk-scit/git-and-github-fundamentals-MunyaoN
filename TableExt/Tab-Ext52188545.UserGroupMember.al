TableExtension 52188545 UserGroupMemberExt extends "User Group Member"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""User Group Code"(Field 1)".

        field(50050; Type; Option)
        {
            CalcFormula = lookup("User Group".Type where(Code = field("User Group Code")));
            FieldClass = FlowField;
            OptionMembers = " ","File Movement";
        }
    }
}

