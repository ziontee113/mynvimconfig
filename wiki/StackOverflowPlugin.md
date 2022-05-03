# Stack Overflow Plugin for Neovim

- Features:
  - Getting answers from SO in Nvim.

@startuml
left to right direction
actor "User" as user
usecase "Ask Question" as askQuestion
usecase "Get Answers" as getAnswers
user --- askQuestion
user --- getAnswers
@enduml
