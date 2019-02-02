codeunit 50102 Skoda
{
    EventSubscriberInstance = Manual;

    var
        _bindingID: Guid;
        _engine: Codeunit IEngine;

    trigger OnRun()
    var
        this: Codeunit Skoda;
    begin
        this.Construct(this);
    end;

    procedure Construct(this: Codeunit Skoda)
    var
        CodeunitVariant: Variant;
        ICarBinder: Codeunit ICarBinder;
    begin
        BindSubscription(this);
        CodeunitVariant := this;
        ICarBinder.OnBindInterfaceToImplementation(CodeunitVariant, _bindingID);

        //Default object state
        _engine.Construct(Codeunit::GasolineEngine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICar, 'OnGetTopSpeed', '', true, true)]
    local procedure OnGetTopSpeed(var topSpeed: Decimal; bindingID: Guid)
    begin
        if (bindingID <> _bindingID) then
            exit;

        topSpeed := 200.00;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICar, 'OnGetEngine', '', true, true)]
    local procedure OnGetEngine(var engine: Codeunit IEngine; bindingID: Guid)
    begin
        if (bindingID <> _bindingID) then
            exit;

        engine := _engine;
    end;
}