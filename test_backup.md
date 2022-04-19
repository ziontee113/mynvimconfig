# One way ticket

@startuml
!define LIGHTBLUE
!includeurl https://raw.github.com/Drakemor/RedDress-PlantUML/master/style.puml

left to right direction

actor :Last actor: as Person1
usecase (Last Usecase) as UC4

Person1 --> UC4

@enduml

@startuml
!define LIGHTBLUE
!includeurl https://raw.github.com/Drakemor/RedDress-PlantUML/master/style.puml
left to right direction
actor "Food Critic" as fc
rectangle Restaurant {
usecase "Eat Food" as UC1
usecase "Pay for Food" as UC2
usecase "Drink" as UC3
}
fc --> UC1
fc --> UC2
fc --> UC3
@enduml
