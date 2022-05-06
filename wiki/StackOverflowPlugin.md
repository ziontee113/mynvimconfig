# Stack Overflow Plugin for Neovim

#### Features:

- Getting answers from Stack Overflow in Neovim.

@startuml
left to right direction
actor "User" as user
actor "API" as api
rectangle {
  usecase "Ask Question" as askQuestion
  usecase "Get Answers" as getAnswers
  user -- askQuestion
  askQuestion ..> getAnswers : <<includes>>
  getAnswers -- api
  usecase "Read Answer" as readAnswer
  user -- readAnswer
}
@enduml
