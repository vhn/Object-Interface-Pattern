codeunit 50100 ICar
{
    var
        _binder: Codeunit ICarBinder;

    procedure Construct(codeunitID: Integer)
    begin
        _binder.Bind(codeunitID, _binder);
    end;

    procedure GetImplementationType(): Integer
    begin
        exit(_binder.GetBoundCodeunitID());
    end;

    procedure GetTopSpeed(): Decimal
    var
        topSpeed: decimal;
    begin
        _binder.OnGetTopSpeed(topSpeed, _binder.GetBindingID());
        exit(topSpeed);
    end;

    procedure GetEngine(var engineOut: Codeunit IEngine)
    begin
        _binder.OnGetEngine(engineOut, _binder.GetBindingID());
    end;
}