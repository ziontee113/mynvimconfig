# One way ticket

```mermaid
flowchart LR
  S[Start] --> A
  A(Enter your email address) --> B{Existing User}
  B -->|No| C(Enter name)
  C --> D{Accept Conditions ?}
  D --> |No| A
  D --> |Yes| E(Send email with magic link)
  B --> |Yes| E
  E --> End
```

```plantuml
Bob -> Alice : Hello Venus
```
