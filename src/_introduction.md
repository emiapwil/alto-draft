---
---

#Introduction

<!-- What is ALTO [[[ -->

The *Application-Layer Traffic Optimization* protocol [RFC7285] can be used to
help applications decide

<!-- ]]] -->

<!-- The scenarios for ALTO [[[ -->

The ALTO protocol are very useful in the following scenarios:

- Multi-homing
  Multi-homed nodes are attached to different access points. Therefore packets
  might travel through different paths for connections both between two
  multi-homed nodes and between a multi-homed node and a normal one. ALTO can be
  used to help decide where the packets of a certain connection should be sent.

- Mobility

- CDN: The

- Fetching distributed resources
  All the above scenarios can be concluded into one model.

<!-- ]]] -->

<!-- The sources of ALTO maps [[[ -->

Depending on how an ALTO server gathers its information we can classify them
into the following three categories:

- *Host-based*
  For a *host-based* server the network acts as a black box, thus information
  such as the costs between endpoints can only be collected using host-based
  measurement methods. For example, an ALTO server can select 10 random pairs of
  hosts from two endpoints and lets the cost between those two endpoints be the
  average RTT.

- *Network-based*
  The *network-based* servers are supposedly hosted by network administrators so
  they are able to make use of *internal* information such as the topologies,
  configurations and statistics.

- *Derived*

<!-- ]]] -->

<!-- endpoint partition [[[ -->
<!-- ]]] -->

<!-- host routing ??? [[[ -->



<!-- ]]] -->

<!-- consistency: snapshots [[[ -->

Version tags

<!-- ]]] -->
