## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| contracts/Roles.sol | d65e69490ad004c1557f5eced0e1ee153276cc22 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **Roles** | Implementation | Auth |||
| └ | setRootUser | Public ❗️ | 🛑  | onlyAuth |
| └ | setUserRole | Public ❗️ | 🛑  | onlyAuth |
| └ | setPublicCapability | Public ❗️ | 🛑  | onlyAuth |
| └ | setRoleCapability | Public ❗️ | 🛑  | onlyAuth |
| └ | getUserRoles | Public ❗️ |   | |
| └ | getCapabilityRoles | Public ❗️ |   | |
| └ | isUserRoot | Public ❗️ |   | |
| └ | isCapabilityPublic | Public ❗️ |   | |
| └ | hasUserRole | Public ❗️ |   | |
| └ | canCall | Public ❗️ |   | |
| └ | bitNot | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
