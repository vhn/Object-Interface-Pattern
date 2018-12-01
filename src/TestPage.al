page 50100 TestPage
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    actions
    {
        area(Processing)
        {
            action(RunTest)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CODEUNIT.RUN(Codeunit::CarInterfaceConsumer);
                end;
            }
        }
    }
}