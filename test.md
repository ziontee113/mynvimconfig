# One way ticket

@startuml
left to right direction

actor "Food Critic" as fc

usecase "Eat Food" as UC1
usecase "Pay for Food" as UC2
usecase "Drink" as UC3

fc --> UC1
fc --> UC2
fc --> UC3
@enduml

@startuml
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

@startuml
:Main Admin: as Admin
(Use the application) as (Use)

User -> (Start)
User --> (Use)

Admin ---> (Use)

note right of Admin : This is an example.

note right of (Use)
A note can also
be on several lines
end note

note "This note is connected\nto several objects." as N2
(Start) .. N2
N2 .. (Use)
@enduml
