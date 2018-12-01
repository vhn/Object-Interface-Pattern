codeunit 50101 ICarBinder
{
    EventSubscriberInstance = Manual;

    var
        _boundCodeunitReference: Variant;
        _boundCodeunitID: Integer;
        _this: Codeunit ICarBinder;
        _readyToBind: Boolean;
        _bindingID: Guid;
        _bindingErr: Label 'Binding with implementation codeunit %1 failed';

    procedure Bind(codeunitID: Integer; this: Codeunit ICarBinder)
    begin
        if (_readyToBind) then
            Destruct();

        _this := this;

        _readyToBind := BindSubscription(_this);
        if (not _readyToBind) then
            Error(_bindingErr, codeunitID);

        if (not Codeunit.Run(codeunitID)) or (not _boundCodeunitReference.IsCodeunit()) then begin
            Destruct();
            Error(_bindingErr, codeunitID);
        end;

        _readyToBind := not UnbindSubscription(_this);
        if (_readyToBind) then begin
            Destruct();
            Error(_bindingErr, codeunitID);
        end;

        _boundCodeunitID := codeunitID;
    end;

    procedure GetBindingID(): Guid
    begin
        exit(_bindingID);
    end;

    procedure GetBoundCodeunitID(): Integer
    begin
        exit(_boundCodeunitID);
    end;

    local procedure Destruct()
    begin
        CLEAR(_boundCodeunitReference); //Dereference the bound implementation codeunit
        if (_readyToBind) then
            _readyToBind := not UnbindSubscription(_this);
        CLEARALL;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICarBinder, 'OnBindInterfaceToImplementation', '', true, true)]
    local procedure OnSubscribeBindInterfaceToImplementation(implementationCodeunit: Variant; var bindingIDOut: Guid)
    begin
        _boundCodeunitReference := implementationCodeunit;
        _bindingID := CreateGuid();
        bindingIDOut := _bindingID;
    end;

    [IntegrationEvent(false, false)]
    procedure OnBindInterfaceToImplementation(implementationCodeunit: Variant; var bindingIDOut: Guid)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnGetTopSpeed(var topSpeed: Decimal; bindingID: Guid)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnGetEngine(var engine: Codeunit IEngine; bindingID: Guid)
    begin
    end;
}