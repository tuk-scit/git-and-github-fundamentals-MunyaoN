
Page 52188460 "HR Leave Batches"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "HR Leave Journal Batch.";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(JournalTemplateName;"Journal Template Name")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(PostingDescription;"Posting Description")
                {
                    ApplicationArea = Basic;
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

