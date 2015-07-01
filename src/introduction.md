
#Introduction

## Problem Statement

The "Application-Layer Traffic Optimization" protocol proposed in [](#RFC7285)
defines several "maps" to publish network information to applications so that
both the network providers and the application users can make better decisions
on traffic steering and eventually achieve better performances.  The fundamental
step to fulfill the promise is to gather the information on the network.

<!-- Motivation: the fact that there are different sources [[[ -->

Extracting information out of the network has been a widely-studied research
topic.  Due to financial, technical and security reasons it is hard to fetch the
required data directly from ISPs, thus many efforts have been made to measure
different metrics using endpoint-based tools.  Since most of these tools require
little support from the network infrastructure, lots of them can still work even
if the Internet architecture evolves.  These measurement techniques can be
valuable sources to ALTO services as the measured results often reflect the
actual performance of the network.

At the same time, Software-Defined Networking makes it much easier for ALTO
service providers to gather information with the centralized programming
paradigm and the global view.  However, there have been plenty of SDN
controller implementations ever since the very first [](#NOX) system.  These
controllers are implemented in different programming languages such as C/C++,
Java and Python, and have different data structures to store the network
information.  Even though RESTful APIs are provided by most controllers, the
formats still varies and different ALTO instances may be interested in different
information.  For example, most cost maps only require the topology view but a
QoS-first cost map also needs bandwidth statistics.

<!-- TODO at least two examples of different topology presentations -->

While there are many different ways to gather and store the network information,
ALTO protocol, which is used between ALTO servers and ALTO clients, is already
well-defined in [](#RFC7285).  Thus the service model for an ALTO server can be
described as it is shown in [](#fig:alto-service-model).

<!-- ]]] -->


                            +--------+  Method 1 +---------------+
                   ALTO     |        | <---------+  Information  |
    +----------+  Protocol  |        |           |   Source  1   |
    |   ALTO   | <--------> |        |           +---------------+
    |  Client  |            |        |
    +----------+            |        |  Method 2 +---------------+
                            |  ALTO  | <---------+  Information  |
                            | Server |           |   Source  2   |
    +----------+   ALTO     |        |           +---------------+
    |   ALTO   |  Protocol  |        |
    |  Client  | <--------> |        |  Method 3 +---------------+
    +----------+            |        | <---------+  Information  |
                            |        |           |   Source  3   |
                            +--------+           +---------------+
^[fig:alto-service-model::Service Model for an ALTO server]

<!-- Motivation: the need to reuse and aggregate meta information [[[ -->



<!-- ]]] -->

<!-- Motivation: reusable functionalities [[[ -->

It is also obvious that requests for maps generated from different sources still
share some common routines related to the ALTO protocol and other basic
functionalities.

<!-- ]]] -->

[](#framework-design) introduces the architecture for a multi-source ALTO
server framework.

## Requirements Language

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD",
"SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be
interpreted as described in [](#RFC2119).
