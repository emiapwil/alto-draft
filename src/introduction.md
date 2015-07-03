
#Introduction

<!-- [[[ -->

<!-- service model not complete [[[ -->

The "Application-Layer Traffic Optimization" protocol proposed in [](#RFC7285)
defines several "maps" to publish network information to applications so that
both the network providers and the application users can make better decisions
on traffic steering and eventually achieve better performance.  However by
specifying the protocol between ALTO clients and servers, [](#RFC7285) only
describes part of the service model.  In this document we focus on the service
model of ALTO servers and in [](#advanced-topics) we discuss a little about what
can be done on the client's side.

A fundamental functionality of the ALTO server is to collect information from
what we call "information sources".  It is not surprising that there are many
different information sources and thus we can describe a more complete service
model for the server's side in [](#fig:alto-service-model).

<!-- Figure: alto-service-model [[[ -->


                            +--------+  Method #1 +---------------+
                   ALTO     |        | <----------+  Information  |
    +----------+  Protocol  |        |            |   Source #1   |
    |   ALTO   | <--------> |        |            +---------------+
    |  Client  |            |        |
    +----------+            |        |  Method #2 +---------------+
                            |  ALTO  | <----------+  Information  |
                            | Server |            |   Source #2   |
    +----------+   ALTO     |        |            +---------------+
    |   ALTO   |  Protocol  |        |
    |  Client  | <--------> |        |  Method #3 +---------------+
    +----------+            |        | <----------+  Information  |
                            |        |            |   Source #3   |
                            +--------+            +---------------+
^[fig:alto-service-model::Service Model for an ALTO server]

<!-- ]]] -->

<!-- ]]] -->

<!-- protocol for common server-is communication [[[ -->

Since the relationships between ALTO servers and information sources can be very
complex, as discussed in [](#relationships), the communication between
them can hardly be unified.  Nevertheless, it is still possible and beneficial
to design a generic protocol to collect statistics for certain implementation
patterns.  [](#alto-sc-protocol) introduces the proposed protocol format in
details.

<!-- ]]] -->

<!-- ird extensions [[[ -->

Another problem arising with multiple information resources is how a single ALTO
server can host together different implementations of ALTO services.  This
problem is related to the management of IRD resources.  Unlike those providing
network statistics, which may vary, the information sources for IRD service are
very much alike.  [](#ird-extensions) discusses how to solve this problem and,
furthermore, introduces several extensions on top of the basic IRD service.

<!-- ]]] -->

<!-- service discovery/selection [[[ -->

At the same time, some real-world issues exist for the ALTO clients: how to
discover the services and how to choose between different candidates.
[](#advanced-topics) discusses these problems and provides some useful
solutions.

<!-- ]]] -->

## Requirements Language

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD",
"SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be
interpreted as described in [](#RFC2119).
