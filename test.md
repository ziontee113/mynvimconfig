# Super Cool Starchart

@startuml
left to right direction

actor "Food Critic" as fc

usecase "Eat Food" as UC1
usecase "Pay for Food" as UC2
usecase "Drink" as UC3
usecase "Go to the Bathroom" as UC4
fc --> UC1
fc --> UC2
fc --> UC3
fc --> UC4
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
left to right direction
actor Guest as g
package Professional {
  actor Chef as c
  actor "Food Critic" as fc
}
package Restaurant {
  usecase "Eat Food" as UC1
  usecase "Pay for Food" as UC2
  usecase "Drink" as UC3
  usecase "Review" as UC4
}
g --> UC1
g --> UC2
g --> UC3
fc --> UC4
@enduml
