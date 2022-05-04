# Stack Overflow Plugin for Neovim

#### Features:
  - Getting answers from Stack Overflow in Neovim.

@startuml
left to right direction
actor "User" as user
usecase "Ask Question" as askQuestion
usecase "Get Answers" as getAnswers
user --- askQuestion
user --- getAnswers
usecase "Buffer" as buffer
getAnswers -- buffer
@enduml

---
#### Challenges:
  - How to use ghost buffers in Neovim.
  - How to get Info from the Stack Overflow API.

#### Directions:
  - Look at the "create a cmp plugin" in Neovim by DevOnDuty.
  - Figure out how to:
    - Create an empty buffer
    - Set buffer text
    - Clear buffer text
  - Get User Input.
