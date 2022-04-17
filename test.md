# One way ticket

```mermaid
flowchart TD
  %%{init: {'theme': 'neutral'} }%%
  S[Start] --> A
  A(Enter your email address) --> B{Existing User}
  B -->|No| C(Enter name)
  C --> D{Accept Conditions ?}
  D --> |No| A
  D --> |Yes| E(Send email with magic link)
  B --> |Yes| E
  E --> End
```

```mermaid
%%{init: {'theme': 'neutral' } }%%
graph LR
A(Foo) --> B(Bar)
B --> C(Baz)
```

---

## Problem

Given a codeblock that starts with 3 `backticks` and ends with 3 `backticks`
Run the check function at one direction, if it hits 3 backticks, check the line
If the line has code identifier, then check the other direction
If checks for only 3 `backticks` == true, execute the function,
otherwise execute something else
