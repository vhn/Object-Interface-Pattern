codeunit 50106 ElectricEngine
{
    EventSubscriberInstance = Manual;

    var
        _bindingID: Guid;

    trigger OnRun()
    var
        this: Codeunit ElectricEngine;
    begin
        BindSubscription(this);
        this.Construct(this);
    end;

    procedure Construct(this: Codeunit ElectricEngine)
    var
        codeunitVariant: Variant;
        IEngineBinder: Codeunit IEngineBinder;
    begin
        codeunitVariant := this;
        IEngineBinder.OnBindInterfaceToImplementation(codeunitVariant, _bindingID);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::IEngineBinder, 'OnGetHorsePower', '', true, true)]
    local procedure OnGetTopSpeed(var horsePower: Decimal; bindingID: Guid)
    begin
        if (bindingID <> _bindingID) then
            exit;

        horsePower := 1000;
    end;
}