codeunit 50108 CarComparison
{
    procedure CompareTopSpeed(car1: Codeunit ICar; car2: Codeunit ICar)
    var
        car1TopSpeed: Decimal;
        car2TopSpeed: Decimal;
        allObj1: Record AllObjWithCaption;
        allObj2: Record AllObjWithCaption;
    begin
        car1TopSpeed := car1.GetTopSpeed();
        car2TopSpeed := car2.GetTopSpeed();

        //We can get the specific type of the implementation codeunit if we want.. 
        allObj1.Get(allObj1."Object Type"::Codeunit, car1.GetImplementationType());
        allObj2.Get(allObj1."Object Type"::Codeunit, car2.GetImplementationType());

        case true of
            car1TopSpeed > car2TopSpeed:
                Message('The %1 (%2 km/h) is faster than the %3 (%4 km/h)!', allObj1."Object Caption", car1TopSpeed, allObj2."Object Caption", car2TopSpeed);
            car1TopSpeed < car2TopSpeed:
                Message('The %3 (%4 km/h) is faster than the %1 (%2 km/h)!', allObj1."Object Caption", car1TopSpeed, allObj2."Object Caption", car2TopSpeed);
            else
                Message('The cars are equally fast, or slow (%1 km/h)!', car1TopSpeed);
        end;
    end;

    procedure CompareEngineHorsePower(car1: Codeunit ICar; car2: Codeunit ICar)
    var
        engine1: Codeunit IEngine;
        engine2: Codeunit IEngine;
        engine1HorsePower: Decimal;
        engine2HorsePower: Decimal;
    begin
        car1.GetEngine(engine1);
        car2.GetEngine(engine2);

        engine1HorsePower := engine1.GetHorsePower();
        engine2HorsePower := engine2.GetHorsePower();

        case true of
            engine1HorsePower > engine2HorsePower:
                Message('The first car (%1) has more horsepower than the second (%2)!', engine1HorsePower, engine2HorsePower);
            engine1HorsePower < engine2HorsePower:
                Message('The second car (%2) has more horsepower than the first (%1)!', engine1HorsePower, engine2HorsePower);
            else
                Message('The engines have the same horsepower (%1)!', engine1HorsePower);
        end;
    end;
}