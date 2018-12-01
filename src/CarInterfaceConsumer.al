codeunit 50109 CarInterfaceConsumer
{
    trigger OnRun()
    begin
        CompareCars();
    end;

    local procedure CompareCars()
    var
        car1: Codeunit ICar;
        car2: Codeunit ICar;
        carComparison: Codeunit CarComparison;
    begin
        //The codeunit IDs could come from persistent setup, be decided runtime or be send to NAV as part of a request from an external system.
        car1.Construct(Codeunit::Skoda);
        car2.Construct(Codeunit::Tesla);

        //The object reference chains will be clean & independent after the object is constructed:
        //Car1 => ICar => ICarBinder => Skoda        
        //Car2 => ICar => ICarBinder => Tesla

        //Notice that ICar has the consumer facing API, while ICarBinder has the implementation facing API.
        //From the consumers point of view, there is no magic or boilerplate or things to consider/keep in mind.

        //Since nothing in the pattern is single instance the objects can live side by side, and go out of scope independently of each other. That also means no manual destructor is necessary.
        //Compared to a discovery event pattern, constructing & using an object through an interface will not grow slower as the number of different possible implementations (car models) grow,
        //since we don't need to broadcast to all possible implementations to find the right one.

        //The only remaining overhead is: since every manually bound subscriber listens to ALL instances of publisher objects rather than one specific instance, performance will
        //be impacted by the number of living implementation object at any given time. Ie. if I instantiate 100 cars and invoke 1 of them, 99 will have to exit out.
        //But since we assume that the 99 other objects will at least be useful, otherwise why were they constructed in the first place, this hopefully has minimal impact compared to 
        //other drawbacks.               

        //We can pass the constructed objects to other codeunits that are written for the interface rather than for hardcoded references:
        carComparison.CompareTopSpeed(car1, car2);

        //The horse power comparison is using a nested object Engine within Car, implemented via the same pattern for illustration purposes.
        carComparison.CompareEngineHorsePower(car1, car2);
    end;
}