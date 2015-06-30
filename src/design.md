
# Framework Design

## Overview

<!-- figure for alto architecture [[[-->

<!-- indent by 4 spaces to include it as a figure -->

    +-------------------------------------------------------------------+
    |                         Network Region                            |
    |                                                                   |
    |                    +-----------+                                  |
    |                    | Routing   |                                  |
    |  +--------------+  | Protocols |                                  |
    |  | Provisioning |  +-----------+                                  |
    |  | Policy       |        |                                        |
    |  +--------------+\       |                                        |
    |                   \      |                                        |
    |                    \     |                                        |
    |  +-----------+      \+---------+                      +--------+  |
    |  |Dynamic    |       | ALTO    | ALTO Protocol        | ALTO   |  |
    |  |Network    |.......| Server  | ==================== | Client |  |
    |  |Information|       +---------+                      +--------+  |
    |  +-----------+      /                                /            |
    |                    /         ALTO SD Query/Response /             |
    |                   /                                /              |
    |          +----------+                  +----------------+         |
    |          | External |                  | ALTO Service   |         |
    |          | Interface|                  | Discovery (SD) |         |
    |          +----------+                  +----------------+         |
    |               |                                                   |
    +-------------------------------------------------------------------+
                    |
          +------------------+
          | Third Parties    |
          |                  |
          | Content Providers|
          +------------------+
^[fig:alto-architecture::Architecture of ALTO]

<!-- ]]] -->
