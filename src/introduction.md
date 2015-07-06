
#Introduction

<!-- [[[ -->

<!-- service model not complete [[[ -->

The "Application-Layer Traffic Optimization" protocol proposed in [](#RFC7285)
defines several "maps" to publish network information to applications so that
both the network providers and the application users can make better decisions
on traffic steering and eventually achieve better performance.  However by
specifying the protocol between ALTO clients and servers, [](#RFC7285) only
describes part of the service model.  In this document we focus on the service
model of ALTO servers.

A fundamental functionality of the ALTO server is to collect information from
what we call "information sources".  It is not surprising that there are many
different information sources and thus we can describe a more complete service
model for the server's side in [](#fig:alto-service-model), where the arrows
indicate the direction of information flow.

<!-- Figure: alto-service-model [[[ -->


                            +--------+  Method #1 +---------------+
                   ALTO     |        | <----------+  Information  |
    +----------+  Protocol  |        |            |   Source #1   |
    |   ALTO   | <--------- |        |            +---------------+
    |  Client  |            |        |
    +----------+            |        |  Method #2 +---------------+
                            |        | <----------+  Information  |
        ...        ...      |  ALTO  |            |   Source #2   |
                            | Server |            +---------------+
    +----------+   ALTO     |        |
    |   ALTO   |  Protocol  |        |    ...           ...
    |  Client  | <--------- |        |
    +----------+            |        |  Method #N +---------------+
                            |        | <----------+  Information  |
                            |        |            |   Source #N   |
                            +--------+            +---------------+
^[fig:alto-service-model::Service Model for an ALTO server]

<!-- ]]] -->

<!-- ]]] -->

<!-- protocol for common server-is communication [[[ -->

Since the relationships between ALTO servers and information sources can be very
complex, as discussed in [](#relationships), the communication between them can
hardly be unified.  Nevertheless, it is still possible and beneficial to design
a generic protocol to collect statistics for servers implemented with certain
patterns of ALTO information bases.

With a standard protocol, the implementation of ALTO servers can be decoupled
from the implementations of information sources, making it much easier to
support the feature of fetching information from multiple sources and to be
compatible with new information sources.  [](#alto-info-protocol) introduces the
proposed protocol format in details.  Despite the initial motivation to help
ALTO server implementations gather necessary information, the protocol can also
be applied as a unified information distribution method.

<!-- ]]] -->

## Requirements Language

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD",
"SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be
interpreted as described in [](#RFC2119).

## Terminology and Notation

This document uses the following terms: Application, ALTO Server, ALTO Client
and ALTO Response defined in [](#RFC5693); Endpoint, ALTO Information and ALTO
Information Base defined in [](#RFC7285).

This document uses the same notations of describing JSON objects in
[](#RFC7285), which are specified in [](#RFC7159).

This document uses the following additional terms: Information Source.

- Information Source
<!-- [[[ -->

    An information source is an entity that provides basic information for ALTO
    servers, see more detailed description in [](#information-sources).

<!-- ]]] -->

