
PageExtension 52188455 pageextension52188455 extends "Human Resources Setup" 
{
    layout
    {
        addafter("Employee Nos.")
        {
            field("Intern Nos.";"Intern Nos.")
            {
                ApplicationArea = Basic;
            }
            field("Contract Nos.";"Contract Nos.")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

