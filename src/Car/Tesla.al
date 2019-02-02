codeunit 50103 Tesla
{
    EventSubscriberInstance = Manual;

    var
        _bindingID: Guid;
        _engine: Codeunit IEngine;

    trigger OnRun()
    var
        this: Codeunit Tesla;
    begin
        this.Construct(this);
    end;

    procedure Construct(this: Codeunit Tesla)
    var
        codeunitVariant: Variant;
        ICarBinder: Codeunit ICarBinder;
    begin
        BindSubscription(this);
        codeunitVariant := this;
        ICarBinder.OnBindInterfaceToImplementation(codeunitVariant, _bindingID);

        //Default object state
        _engine.Construct(Codeunit::ElectricEngine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICar, 'OnGetTopSpeed', '', true, true)]
    local procedure OnGetTopSpeed(var topSpeed: Decimal; bindingID: Guid)
    begin
        if (bindingID <> _bindingID) then
            exit;

        topSpeed := 400.00;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICar, 'OnGetEngine', '', true, true)]
    local procedure OnGetEngine(var engine: Codeunit IEngine; bindingID: Guid)
    begin
        if (bindingID <> _bindingID) then
            exit;

        engine := _engine;
    end;
}