codeunit 50107 GasolineEngine
{
    EventSubscriberInstance = Manual;

    var
        _bindingID: Guid;

    trigger OnRun()
    var
        this: Codeunit GasolineEngine;
    begin
        this.Construct(this);
    end;

    procedure Construct(this: Codeunit GasolineEngine)
    var
        codeunitVariant: Variant;
        IEngineBinder: Codeunit IEngineBinder;
    begin
        BindSubscription(this);
        codeunitVariant := this;
        IEngineBinder.OnBindInterfaceToImplementation(codeunitVariant, _bindingID);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::IEngineBinder, 'OnGetHorsePower', '', true, true)]
    local procedure OnGetTopSpeed(var horsePower: Decimal; bindingID: Guid)
    begin
        if (bindingID <> _bindingID) then
            exit;

        horsePower := 100;
    end;
}