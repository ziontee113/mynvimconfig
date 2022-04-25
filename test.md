# Super Cool Starchart

@startuml
left to right direction
actor "John" as john #skyblue;line:blue;line.bold;text:blue
actor "Mary" as mary #pink;line:red;line.bold;text:red
actor "Jack" as jack
actor "Jayce" as jayce
usecase "Eat" as eat
usecase "Eat Spagetti" as eatSpagetti
usecase "Drink" as drink
usecase "Smoke" as smoke

john --> eat
john --> smoke
john --> drink
mary --> eat
mary --> drink
jack ..> eatSpagetti
eatSpagetti <-- jayce
@enduml

@startuml
start
:init;
-> test of color;
if (color?) is (<color:red>red) then
:print red;
else 
:print not red;
note right: no color
endif
partition End {
:end;
}
-> this is the end;
end
@enduml
