## Object Interface Pattern
This is a design pattern for AL and C/AL.
It uses manually bound event subscribers at both the interface layer and the implementation layer to allow consumers of the interface to work with none of the drawbacks or boilerplate commonly seen in other NAV/BC design patterns that address loose coupling and polymorphism. Usually those drawbacks are one or more of the following:
- Parameter records that only supports simple types (or binary..).
- Single instance codeunits at parts of the pattern requiring either singleton design, no global state or manual destruction of global state instead of relying on normal variable scoping to clean up.
- Stateless implementation (this one usually comes with initializing a new object every time the implementation is invoked which impacts performance - See https://youtu.be/jGdkpTGmCgs?t=3995 for more info on that, that talk was also the whole inspiration for this pattern..).


This pattern has none of these drawbacks, but it's still not perfect. It'll probably make debugging harder if taken to extremes since the language doesn't help you with any of this and if you have a lot of instantiated objects at the same time via the same interface there will be overhead when invoking one of them since manually bound subscribers still listen to ALL instantiated objects containing their corresponding publisher..

Microsoft should add a proper solution to this design problem in the language/runtime but until they do, this is the best pattern I can imagine when you need to build a generic framework and your daily work revolves around NAV/BC.
All of this should work in NAV2016 and newer, including AppSource extensions, since it only relies on manually bound events and CODEUNIT.RUN

Check out CarInterfaceConsumer.al first if you want to understand why this pattern can be useful.
The TestPage.al has an action that will run the consumer so you can see it in action.

Microsoft MVP Vjeko blogged about this repo, go read his post if you want more info:
https://vjeko.com/2019/02/02/codeunit-interfaces-in-al/


## Update:
Microsoft is finally solving this platform/language limitation officially: https://youtu.be/bRphFZEirMw?t=4152
It will be released in the BC16 Spring 2020 release at which point this pattern should be considered 100% deprecated:
https://docs.microsoft.com/en-us/dynamics365-release-plan/2020wave1/dynamics365-business-central/al-interfaces
