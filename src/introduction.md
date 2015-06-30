
#Introduction

The "Application-Layer Traffic Optimization" protocol proposed in [](#RFC7285)
defines several "maps" to publish network information to applications so that
both the network providers and the application users can achieve better
performances.

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
paradigm and the global view.  However, there have been a plenty of SDN
controller implementations ever since the very first [](#NOX).  These
controllers are implemented in different programming languages such as C/C++,
Java and Python, and have different data structures to store the network
information.  Even though RESTful APIs are provided by most controllers, the
formats still varies.

<!-- TODO at least two examples of different topology presentations -->

<!-- ]]] -->


<!-- Motivation: the need to reuse and aggregate information [[[ -->



<!-- ]]] -->

<!-- Motivation: reusable functionalities [[[ -->



<!-- ]]] -->

[](#framework-design) introduces the architecture for a multi-source ALTO
server framework.

## Requirements Language

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD",
"SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be
interpreted as described in [](#RFC2119).
