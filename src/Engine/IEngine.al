codeunit 50104 IEngine
{
    var
        _binder: Codeunit IEngineBinder;

    procedure Construct(codeunitID: Integer)
    begin
        _binder.Bind(codeunitID, _binder);
    end;

    procedure GetImplementationType(): Integer
    begin
        exit(_binder.GetBoundCodeunitID());
    end;

    procedure GetHorsePower(): Decimal
    var
        horsePower: decimal;
    begin
        OnGetHorsePower(horsePower, _binder.GetBindingID());
        exit(horsePower);
    end;


    [IntegrationEvent(false, false)]
    procedure OnGetHorsePower(var horsePower: Decimal; bindingID: Guid)
    begin
    end;
}